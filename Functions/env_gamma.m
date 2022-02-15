function env = env_gamma(good_len, bad_len, k_good, k_bad, n)
alpha_adj = k_good / good_len;
beta_adj = k_bad / bad_len;
env = ones(1, n) ;
states = zeros(1, n);
states(1) = 1;
for i = 1:n-1
    temp = states(i); %this is the memory of the markov chain
    r_env = rand;
    %if env is good a
    if (temp > 0)
        % and swithing happens
        if (r_env < alpha_adj)
            if (temp < k_good)
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
            if (temp > - k_bad)
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