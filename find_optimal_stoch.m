% In this file we compute the optimal dormancy switching proabilities for
% each environment and each population type. This will be stored in a 4
% dimensional matrix stoch_temp(n_tau, n_k, n_delays, 2).
% We compute the optimal switching probabilities by computing the lyapunov
% exponent n_runs times and taking the average for each value of (x,y)
% initiation and resuscitation probability. We then take the pair (x,y)
% that maximized the lyapunov exponent and store it in stoch_temp
clc
clear

addpath Functions
load 'Data/parameters.mat'
%%
% Define variables and parameters
pars.n = 500; % number of events
n_runs = 1000;

delays = [0, 1, 2, 4, 6, 8, 10];
n_delays = length(delays);
tau_vals = [2, 4, 6, 8, 10, 20];
n_tau = length(tau_vals);
xy_vals = linspace(0, 1, 21);
n_xy = length(xy_vals);

% k_vals(i,j) is the number of transition states for m(i) and tau(j) 
k_vals = [[1, -1, -1, -1]; [1, 2, 2, 3]; [1, 2, 4, 5]; [1, 2, 6, 7];...
    [1, 2, 8, 9]; [1, 2, 18, 19]];
n_k = 4; % number of vals for k
%%
L_temp_new = zeros(n_delays, n_xy, n_xy);
stoch_temp = zeros(n_tau, n_k, n_delays, 2); %optimal switching x and y
tic
count = 1;
for i_tau = 1:n_tau
    for i_k = 1:n_k
        % compute optimal switching for each environment type
        L_temp = zeros(n_delays, n_xy, n_xy);
        
        % if the environment is unfeasible there is no optimal switching 
        if k_vals(i_tau, i_k) == -1
            opt_switch = NaN(n_delays, 2);
        else
            k_good = k_vals(i_tau, i_k);
            k_bad = k_vals(i_tau, i_k);
            
            for i_run = 1:n_runs
                % simulate environment
                env = env_gamma(tau_vals(i_tau), tau_vals(i_tau), k_good, k_bad, pars.n);
                for i_delay = 1:n_delays
                    t = ones(1, delays(i_delay) + 2);
                    for i_x = 1:n_xy
                        for i_y = 1:n_xy
                            % define transition probabilities
                            t(1) = xy_vals(i_x);
                            t(end) = xy_vals(i_y);
                            pars.t = t;
                            
                            % compute new Lyapunov exponent and add it to
                            % previous matrix
                            L_temp_new(i_delay, i_x, i_y) = ...
                                Lyapunov_fct(stochastic_fct(env, pars));
                            L_temp(i_delay, i_x, i_y) = ...
                                L_temp(i_delay, i_x, i_y)...
                                + L_temp_new(i_delay, i_x, i_y);
                        end
                    end
                end
            end
            L_temp = L_temp / n_runs; % take average of all Lyapunov exponent
            %_____________________________________________________________
            % Find maximum and opt indices of L_temp for every delay
            max_val = -10 * ones(n_delays, 1);
            opt_ind = -1 * ones(n_delays, 2);
            for i_delay = 1:n_delays
                for i_x = 1:n_xy
                    for i_y = 1:n_xy
                        temp_val = L_temp(i_delay, i_x, i_y);
                        if temp_val > max_val(i_delay)
                            max_val(i_delay) = temp_val;
                            opt_ind(i_delay, :) = [i_x, i_y];
                        end
                    end
                end
            end
            opt_switch = xy_vals(opt_ind);
        end
        % store optimal switching probabilities for each environment 
        stoch_temp(i_tau, i_k, :, :) = opt_switch;
        %display progress since this takes a long time
        temp = sprintf('Yay we are done with step %i out of %i', count, n_tau*n_k);
        disp(temp)
        count = count + 1;
    end
end
toc
%%
save('stoch_opt.mat', 'stoch_temp');