clc
clear

addpath Functions
%%
%here we use the estimates from find_optimal_stoch to limit the search area
%for optimal probabilities and do more runs 
%Define variables and parameters
pars.r = 2; % reproduction rate during good times
pars.p = 0.5; % overall probability of a bad event
pars.n = 500; % number of events
pars.w = .5; % percentage of A and transition states which survives during bad times
disp(pars.p * pars.r/(pars.r-1) - (1-pars.p) * pars.w/(1-pars.w)) % theor optimal in kelly theory
n_runs = 1000;
init_v = 10^2;
pars.lam = 1;

delays = [0, 1, 2, 4, 6, 8, 10];
n_delays = length(delays);
vals = linspace(0, 1, 41);
env_mu = [2, 4, 6, 8, 10, 20];
n_env = length(env_mu);

%m_vals(i,j) is the number of transition states for m(i) and tau(j) 
m_vals = [[1, -1, -1, -1]; [1, 2, 2, 3]; [1, 2, 4, 5]; [1, 2, 6, 7];...
    [1, 2, 8, 9]; [1, 2, 18, 19]];
n_m = 4; %number of vals for m
load Data/stoch_opt_41vals_100runs.mat
dv = 0.025;
%%
stoch_temp_new = zeros(n_env, n_m, n_delays, 2); %optimal switching x and y
tic
count = 1;
for i_env = 1:n_env
    for i_m = 1:n_m
        L_temp = zeros(n_delays, 5, 5);
        if m_vals(i_env, i_m) == -1
            opt_switch = NaN(n_delays, 2);
        else
            for i_run = 1:n_runs
                k_good = m_vals(i_env, i_m);
                k_bad = m_vals(i_env, i_m);
                env = env_gamma(env_mu(i_env), env_mu(i_env), k_good, k_bad, pars.n);
                for i_delay = 1:n_delays
                    t = ones(1, delays(i_delay) + 2);
                    opt_x = stoch_temp(i_env,i_m, i_delay, 1);
                    opt_y = stoch_temp(i_env,i_m, i_delay, 2);
                    
                    x_vals = [opt_x-2*dv, opt_x-dv, opt_x, opt_x+dv, opt_x+2*dv];
                    y_vals = [opt_x-2*dv, opt_x-dv, opt_x, opt_x+dv, opt_x+2*dv];
                    x_vals = x_vals(x_vals >= 0);
                    y_vals = y_vals(y_vals >= 0);
                    count_x = 1;
                    for i_x = x_vals
                        count_y = 1;
                        for i_y = y_vals
                            t(1) = i_x;
                            t(end) = i_y;
                            pars.t = t;

                            L_temp(i_delay, count_x, count_y) = ...
                                L_temp(i_delay, count_x, count_y)...
                                + Lyapunov_fct(stochastic_fct(init_v, env, pars));
                            count_y = count_y + 1;
                        end
                        count_x = count_x + 1;
                    end
                end
            end
            L_temp = L_temp / n_runs;
            %_____________________________________________________________
            % Now we find in a really stupid way where the max value is obtained
            max_val = -10 * ones(n_delays, 1);
            opt_ind = -1 * ones(n_delays, 2);
            %find max overal
            for i_delay = 1:n_delays
                opt_x = stoch_temp(i_env,i_m, i_delay, 1);
                opt_y = stoch_temp(i_env,i_m, i_delay, 2);

                x_vals = [opt_x-2*dv, opt_x-dv, opt_x, opt_x+dv, opt_x+2*dv];
                y_vals = [opt_x-2*dv, opt_x-dv, opt_x, opt_x+dv, opt_x+2*dv];
                x_vals = x_vals(x_vals >= 0);
                y_vals = y_vals(y_vals >= 0);
                count_x = 1;
                for i_x = x_vals
                    count_y = 1;
                    for i_y = y_vals
                        temp_val = L_temp(i_delay, count_x, count_y);
                        if temp_val > max_val(i_delay)
                            max_val(i_delay) = temp_val;
                            opt_switch(i_delay, :) = [i_x, i_y];
                        end
                        count_y = count_y + 1;
                    end
                    count_x = count_x + 1;
                end
            end
        end
        stoch_temp_new(i_env, i_m, :, :) = opt_switch;
        %temp = sprintf('Yay we are done with step %i out of %i', count, n_env*n_m);
        %disp(temp)
        count = count + 1;
    end
end
toc
%%
save('stoch_opt_refined.mat', 'stoch_temp_new');