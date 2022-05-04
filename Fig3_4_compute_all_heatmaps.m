% For this figure we compute all fitness maps for the two fitness maps for a population with no
% delays to enter dormancy and for a population with delay 1
clc
clear

addpath Functions
load 'Data/parameters.mat'
%%
% Here we will compute the final abundancy for 0, 5, 10 and 20 transition states
% We will do so for all values of x and y between 0 and 1 while keeping everything else fixed
%Define variables and parameters
pars.n = 500; % number of events
n_runs = 10;

vals = linspace(0, 1, 41);
n_val = length(vals);
env_mu = [7, 6, 5, 4, 3, 2];
k_vals = [1, 2, 3, 4, 5, 6, 7];
n_k = length(k_vals);
n_env = length(env_mu);
%%
figure()
tic
L_temp = zeros(n_env, n_k, n_val, n_val);
t_len = 2;
t = ones(1, t_len);
max_val = -5;
for i_mu = 1:n_env
    for i_k = 1:n_k
        for i_run = 1:n_runs
            env = env_gamma(env_mu(i_mu), env_mu(i_mu), k_vals(i_k), ...
                k_vals(i_k), pars.n);
            for i_x = 1:n_val
                for i_y = 1:n_val
                    t(1) = vals(i_x);
                    t(end) = vals(i_y);
                    pars.t = t;
                    
                    L_temp_new = Lyapunov_fct(stochastic_fct(env, pars));
                    L_temp(i_mu, i_k, i_x, i_y) = ...
                        L_temp(i_mu, i_k, i_x, i_y) + L_temp_new;
                end
            end
        end
        L_temp(i_mu, i_k, :, :) = L_temp(i_mu, i_k, :, :) / n_runs;
        max_temp = max(max(L_temp(i_mu, i_k, :, :)));
        if max_temp > max_val
            max_val = max_temp;
        end
    end
end
toc
beep
%%
if t_len == 2
    save('Fig3_4_del0.mat','L_temp')
elseif t_len == 3
    save('Fig3_4_del1.mat','L_temp')
end