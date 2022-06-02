% This function simulates a stochastic environment with average residence 
% time of good and bad environments good_len, respectively bad_len and
% minimum residence time of good env k_good and minimum length of bad env
% k_bad. The total length of env is n and 1 represents a good environment,
% while 0 represents a bad environment

function env = env_gamma(tau_g, tau_b, k_g, k_b, n)
alpha_adj = k_g / tau_g; % transition probability in Markov chain
beta_adj = k_b / tau_b; % transition probability in Markov chain
env = ones(1, n) ;
states = zeros(1, n);
states(1) = 1; % first state is good by default 

for i = 1:n-1
    temp = states(i); %this is the memory of the markov chain
    r_env = rand;
    %if env is good 
    if (temp > 0)
        % and swithing happens
        if (r_env < alpha_adj)
            if (temp < k_g)
               states(i + 1) = temp + 1;
               env(i+1) = 1;
            else
               states(i + 1) = -1;
               env(i+1) = 0;
            end
        %if env is good and swithing does not happen
        else
            env(i+1) = 1;
            states(i+1) = temp;
        end
    else
        %if env bad and switching happens
        if (r_env < beta_adj)
            if (temp > - k_b)
               states(i + 1) = temp - 1;
               env(i+1) = 0;
            else
               states(i + 1) = 1;
               env(i+1) = 1;
            end
        %if env is bad and switching does not happen
        else
            env(i+1) = 0;
            states(i+1) = temp;
        end
    end
end