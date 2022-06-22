% For this figure we plot all the fitness maps we computed
% Fig3_4_compute_all_heatmaps
clc 
clear 

addpath Functions
%for delay 0 load Data/Fig3_4_del0.mat
%for delay 1 load Data/Fig3_4_del1.mat
load Data/Fig3_4_all_del0.mat 
load Data/parameters.mat
%%
xy_vals = pars.xy_vals;
n_val = length(xy_vals);
env_tau = [7, 6, 5, 4, 3, 2];
m_vals = [1, 2, 3, 4, 5, 6, 7];
n_k = length(m_vals);
n_env = length(env_tau);
%%
max_val = max(max(max(max(L_temp)))); % maximum value for all subplots
figure('Position', [200, 200, 900, 1000])
clims = [0, max_val];
subplot_index = 1;
ax_names = {};
t = tiledlayout(n_env, n_k);
vals_short = linspace(0, 1, 6);
xvals_short = [0, .2, .4, .6, .8, 1];
yvals_short = [1, .8, .6, .4, .2, 0];

for i_tau = 1:n_env
    for i_k = 1:n_k
        %plot fitness map for each value of tau and kappa
        ax_names{subplot_index} = nexttile;
        yticklabels(ax_names{subplot_index},{})
        xticklabels(ax_names{subplot_index},{})
        if m_vals(i_k) < env_tau(i_tau)
            L_temp_plot = reshape(L_temp(i_tau, i_k, :, :), [n_val, n_val]);     
            imagesc(ax_names{subplot_index}, flipud(L_temp_plot), clims);
            hold on 
            [x_max, y_max] = find(L_temp_plot == max(max(L_temp_plot)));
            plot(y_max, n_val + 1 - x_max, 'rx', 'LineWidth', 1.5, 'MarkerSize', 5)
            yticklabels(ax_names{subplot_index},{})
            xticklabels(ax_names{subplot_index},{})
            %title(['\tau = ',num2str(env_tau(i_tau)),', m = ', num2str(m_vals(i_m))])
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
xlabel(t,'Minimum residence time \kappa', 'FontSize', 20)
ylabel(t,'Mean residence time \tau', 'FontSize', 20)
t.TileSpacing = 'compact';
cb = colorbar('FontSize',16);
ylabel(cb, 'Lyapunov exponent')
a = get(cb);
a = a.Position; %gets the positon and size of the color bar
%set(cb,'Position',[a(1)+10 a(2)+10 2 2])% To change size
