clc 
clear 

addpath Functions
load Data/vary_k_mu.mat
%%
vals = linspace(0, 1, 21);
n_val = length(vals);
env_tau = [7, 6, 5, 4, 3, 2];
m_vals = [1, 2, 3, 4, 5, 6, 7];
n_m = length(m_vals);
n_env = length(env_tau);
%%
max_val = max(max(max(max(L_temp)))); % maximum value for all subplots
figure('Position', [200, 200, 900, 1000])
clims = [0, max_val];
subplot_index = 1;
ax_names = {};
t = tiledlayout(n_env, n_m);
vals_short = linspace(0, 1, 6);
xvals_short = [0, .2, .4, .6, .8, 1];
yvals_short = [1, .8, .6, .4, .2, 0];

for i_tau = 1:n_env
    for i_m = 1:n_m
        ax_names{subplot_index} = nexttile;
        yticklabels(ax_names{subplot_index},{})
        xticklabels(ax_names{subplot_index},{})
        if m_vals(i_m) < env_tau(i_tau)
            L_temp_plot = reshape(L_temp(i_tau, i_m, :, :), [n_val, n_val]);     
            imagesc(ax_names{subplot_index}, flipud(L_temp_plot), clims);
            hold on 
            [x_max, y_max] = find(L_temp_plot == max(max(L_temp_plot)));
            plot(y_max, n_val + 1 - x_max, 'rx', 'LineWidth', 1.5, 'MarkerSize', 5)
            yticklabels(ax_names{subplot_index},{})
            xticklabels(ax_names{subplot_index},{})
            %title(['\tau = ',num2str(env_tau(i_tau)),', m = ', num2str(m_vals(i_m))])
            if mod(subplot_index, n_m) == 1
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
