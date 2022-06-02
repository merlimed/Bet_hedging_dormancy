% In this file we reevaluate the optimal dormancy switching proabilities based
% on the results from find_optimal_stoch. We increase the resolution and
% compute the lyapunov exponent in a small vecinity of the values
% previously obtained

clc
clear

addpath Functions
load 'Data/parameters.mat'
load Data/stoch_opt.mat
%%
%here we use the estimates from find_optimal_stoch to limit the search area
%for optimal probabilities and do more runs 
%Define variables and parameters
delays = pars.delays;
n_delays = length(delays);
tau_vals = pars.env_tau;
n_tau = length(tau_vals);

%k_vals(i,j) is the number of transition states tau(i) and k(j)
k_vals = pars.k_vals;
n_k = size(k_vals, 2); %number of vals for k
dv = 0.025; % resolution step
%%
stoch_temp_new = zeros(n_tau, n_k, n_delays, 2); %optimal switching x and y
opt_fitness = zeros(n_tau, n_k, n_delays); %optimal switching x and y

tic
count = 1;
for i_tau = 1:n_tau
    for i_k = 1:n_k
        L_temp = zeros(n_delays, 5, 5); 
        if k_vals(i_tau, i_k) == -1
            opt_switch = NaN(n_delays, 2);
        else
            k_good = k_vals(i_tau, i_k);
            k_bad = k_vals(i_tau, i_k);
            
            for i_run = 1:pars.n_runs
                env = env_gamma(tau_vals(i_tau), tau_vals(i_tau), k_good, k_bad, pars.n);
                for i_delay = 1:n_delays
                    t = ones(1, delays(i_delay) + 2);
                    opt_x = stoch_temp(i_tau, i_k, i_delay, 1);
                    opt_y = stoch_temp(i_tau, i_k, i_delay, 2);
                    
                    %check values around previously computed optimal switching 
                    x_vals = [opt_x-2*dv, opt_x-dv, opt_x, opt_x+dv, opt_x+2*dv];
                    y_vals = [opt_y-2*dv, opt_y-dv, opt_y, opt_y+dv, opt_y+2*dv];
                    x_vals = x_vals(x_vals >= 0);
                    y_vals = y_vals(y_vals >= 0);
                    
                    for i_x = 1:length(x_vals)
                        for i_y = 1:length(y_vals)
                            t(1) = x_vals(i_x);
                            t(end) = y_vals(i_y);
                            pars.t = t;

                            L_temp(i_delay, i_x, i_y) = ...
                                L_temp(i_delay, i_x, i_y)...
                                + Lyapunov_fct(stochastic_fct(env, pars));
                        end
                    end
                end
            end
            L_temp = L_temp / pars.n_runs;
            %_____________________________________________________________
            %We find where the max value is obtained
            max_val = -10 * ones(n_delays, 1);
            opt_ind = -1 * ones(n_delays, 2);
            %find max overal
            for i_delay = 1:n_delays
                opt_x = stoch_temp(i_tau, i_k, i_delay, 1);
                opt_y = stoch_temp(i_tau, i_k, i_delay, 2);

                x_vals = [opt_x-2*dv, opt_x-dv, opt_x, opt_x+dv, opt_x+2*dv];
                y_vals = [opt_y-2*dv, opt_y-dv, opt_y, opt_y+dv, opt_y+2*dv];
                x_vals = x_vals(x_vals >= 0);
                y_vals = y_vals(y_vals >= 0);

                for i_x = 1:length(x_vals)
                    for i_y = 1:length(y_vals)
                        temp_val = L_temp(i_delay, i_x, i_y);
                        if temp_val > max_val(i_delay)
                            max_val(i_delay) = temp_val;
                            opt_switch(i_delay, :) = [x_vals(i_x), y_vals(i_y)];
                        end
                    end
                end
            end
        end
        opt_fitness(i_tau, i_k, :) = max_val;
        stoch_temp_new(i_tau, i_k, :, :) = opt_switch;
        temp = sprintf('Yay we are done with step %i out of %i', count, n_tau * n_k);
        disp(temp)
        count = count + 1;
    end
end
toc
%%
save('Data/stoch_opt_refined.mat', 'stoch_temp_new');
save('Data/opt_fitness.mat', 'opt_fitness');