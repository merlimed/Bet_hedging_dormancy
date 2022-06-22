% For this figure we compute the two fitness maps for a population with no
% delays to enter dormancy and for a population with delay 1
clc
clear
addpath Functions
%%
%Define variables and parameters
load 'Data/parameters.mat'

xy_vals = pars.xy_vals;
n_val = length(xy_vals); %tick values for x and y

%%
tic
tau_G = 2; % mean residence good time
tau_B = 2; % mean residence bad time
k_G = 1; % minimum residence good time
k_B = 1; % minimum residence bad time
L_fin = zeros(n_val, n_val); %final fitness map for no delay
L_fin_delay = zeros(n_val, n_val); %final fitness map for one delay

for i_run = 1:pars.n_runs
    %simulate environment
    env = env_gamma(tau_G, tau_B, k_G, k_B, pars.n);
    t = ones(1, 2); %transition vector for no delay
    t_delay = ones(1, 3); %transition vector for one delay
    for i_x = 1:n_val
        for i_y = 1:n_val
            %update transition probabilities 
            t(1) = xy_vals(i_x);
            t(end) = xy_vals(i_y);
            t_delay(1) = xy_vals(i_x);
            t_delay(end) = xy_vals(i_y);
            pars.t = t;

            %compute lyapunov exp for both no delay and delay
            temp = Lyapunov_fct(stochastic_fct(env, pars));
            L_fin(i_x, i_y) = L_fin(i_x, i_y) + temp;
            
            pars.t = t_delay;
            temp = Lyapunov_fct(stochastic_fct(env, pars));
            L_fin_delay(i_x, i_y) = L_fin_delay(i_x, i_y) + temp;
        end
    end
end
L_fin = L_fin / pars.n_runs;
L_fin_delay = L_fin_delay / pars.n_runs;
toc
beep
%% Save both heatmaps
save('Data/heatmap_nodelay.mat', 'L_fin')
save('Data/heatmap_onedelay.mat', 'L_fin_delay')