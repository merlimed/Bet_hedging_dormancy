% For this figure we compute fitness maps for for a population with no
% delays to enter dormancy and for a population with delay 1
clc
clear

addpath Functions
load 'Data/parameters.mat'
%%
%Define variables and parameters

xy_vals = pars.xy_vals;
n_val = length(xy_vals);
env_tau = [7, 6, 5, 4, 3, 2];
k_vals = [1, 2, 3, 4, 5, 6, 7];
n_k = length(k_vals);
n_env = length(env_tau);
%%
tic
%save fitness maps in L_temp
L_temp = zeros(n_env, n_k, n_val, n_val); 
% length of transition probabilities, 2 means no delay 3 means delay of 1
t_len = 3; 
t = ones(1, t_len);
max_val = -5;
for i_tau = 1:n_env
    for i_k = 1:n_k
        for i_run = 1:pars.n_runs
            %simulate stochastic environment for every run
            env = env_gamma(env_tau(i_tau), env_tau(i_tau), k_vals(i_k), ...
                k_vals(i_k), pars.n);
            for i_x = 1:n_val
                for i_y = 1:n_val
                    t(1) = xy_vals(i_x);
                    t(end) = xy_vals(i_y);
                    pars.t = t;
                    %compute fitness
                    L_temp_new = Lyapunov_fct(stochastic_fct(env, pars));
                    L_temp(i_tau, i_k, i_x, i_y) = ...
                        L_temp(i_tau, i_k, i_x, i_y) + L_temp_new;
                end
            end
        end
        % average fitness
        L_temp(i_tau, i_k, :, :) = L_temp(i_tau, i_k, :, :) / pars.n_runs;
        temp = sprintf('Yay we are done with step %i out of %i',i_k + (i_tau-1)*n_k, n_env*n_k);
        disp(temp)
    end
end
toc
beep
%% save fitness maps 
if t_len == 2
    save('Fig3_4_all_del0.mat','L_temp')
elseif t_len == 3
    save('Fig3_4_all_del1.mat','L_temp')
end     