clc
clear

addpath Functions
%%
% Here we will compute the final abundancy for 0, 5, 10 and 20 transition states
% We will do so for all values of x and y between 0 and 1 while keeping everything else fixed
%Define variables and parameters
pars.r = 2; % reproduction rate during good times
pars.p = 0.5; % overall probability of a bad event
pars.n = 500; % number of events
pars.w = .5; % percentage of A and transition states which survives during bad times
pars.lam = 1; % survival of dormant during good/ bad times
disp(pars.p * pars.r/(pars.r-1) - (1-pars.p) * pars.w/(1-pars.w))
n_runs = 100;
init_v = 10^2;

vals = linspace(0, 1, 21);
n_val = length(vals);
env_mu = [7, 6, 5, 4, 3, 2];
k_vals = [1, 2, 3, 4, 5, 6, 7];
n_k = length(k_vals);
n_env = length(env_mu);

figure()
tic
L_temp = zeros(n_env, n_k, n_val, n_val);
t = ones(1, 2);
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
                    
                    L_temp_new = Lyapunov_fct(stochastic_fct(init_v, env, pars));
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
max_val = max(max(max(max(L_temp))));
figure('Position', [200, 200, 900, 1000])
clims = [0, max_val];
subplot_index = 1;
ax_names = {};
t = tiledlayout(n_env, n_k);
vals_short = linspace(0, 1, 6);
xvals_short = [0, .2, .4, .6, .8, 1];
yvals_short = [1, .8, .6, .4, .2, 0];

for i_mu = 1:n_env
    for i_k = 1:n_k
        ax_names{subplot_index} = nexttile;
        yticklabels(ax_names{subplot_index},{})
        xticklabels(ax_names{subplot_index},{})
        if k_vals(i_k) < env_mu(i_mu)
            L_temp_plot = reshape(L_temp(i_mu, i_k, :, :), [n_val, n_val]);
            imagesc(ax_names{subplot_index}, flipud(L_temp_plot), clims);
            hold on
            [x_max, y_max] = find(L_temp_plot == max(max(L_temp_plot)));
            plot(y_max, n_val + 1 - x_max, 'rx', 'LineWidth', 1.5, 'MarkerSize', 5)
            yticklabels(ax_names{subplot_index},{})
            xticklabels(ax_names{subplot_index},{})
            
            if mod(subplot_index, n_k) == 1
                ax_names{subplot_index}.YTick = 1 + vals_short * (n_val - 1);
                ax_names{subplot_index}.YTickLabels = yvals_short';
                ylabel('y')
            end
            if subplot_index > 30
                ax_names{subplot_index}.XTick = 1 + vals_short * (n_val - 1);
                ax_names{subplot_index}.XTickLabels = xvals_short';
                xlabel('x')
            end
            
        end
        subplot_index = subplot_index + 1;
    end
end
linkaxes([ax_names{1}, ax_names{3}, ax_names{4}, ax_names{5}, ax_names{6}...
    ], 'y');
set(gca,'xaxisLocation','top')
xlabel(t,'Environmental predictability m', 'FontSize', 20)
ylabel(t,'Mean environmental time \tau', 'FontSize', 20)
t.TileSpacing = 'compact';
cb = colorbar('FontSize',16);
