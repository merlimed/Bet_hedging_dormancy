% For this figure we compute the two fitness maps for a population with no
% delays to enter dormancy and for a population with delay 1
clc
clear
load('Data/heatmap_nodelay.mat')
load('Data/heatmap_onedelay.mat')

xy_vals = linspace(0, 1, 41);% all values for x and y
vals_short = linspace(0, 1, 11); 
n_val = length(xy_vals); %tick values for x and y

%% Define color map
my_c = spring;
my_c(1:150,1) = linspace(.7, 1, 150);
my_c(:,3) = my_c(:,3)./linspace(1.8, 1, 256)';

%% plot
%find max ind
[x0_max, y0_max] = find(L_fin == max(max(L_fin)));
[x1_max, y1_max] = find(L_fin_delay == max(max(L_fin_delay)));

yvals = [1, .95, .9, .85, .8, .75, .7, .65, .6, .55, .5, .45, .4, .35, ...
    .3, .25, .2, .15, .1, .05, 0];
yvals_short = [1, .9, .8, .7, .6, .5, .4, .3, .2, .1, 0];
figure('Position', [200 350 1050 370])
subplot(1,2,1)
ax1 = gca;
clims = [0, max(max(L_fin))];
imagesc(ax1, flipud(L_fin), clims);
colormap(ax1, my_c)
hold on 
plot(y0_max, n_val +1 - x0_max, 'rx', 'LineWidth', 3, 'MarkerSize', 14)

set(ax1, 'FontSize', 14)
ax1.XTick = 1 + vals_short * (n_val - 1);
ax1.YTick = 1 + vals_short * (n_val - 1);
ax1.XTickLabels = vals_short;
ax1.YTickLabels = yvals_short;
title('\tau = 2, \kappa = 1', 'FontSize', 16)
xlabel('Initiation x', 'FontSize', 16)
ylabel('Resuscitation y', 'FontSize', 16)
c = colorbar('FontSize',16);
c.Label.String = 'Lyapunov exponent';

subplot(1,2,2)
ax2 = gca;
clims = [0, max(max(L_fin))];
imagesc(ax2, flipud(L_fin_delay), clims);
hold on
plot(y1_max, n_val + 1 - x1_max, 'rx', 'LineWidth', 3, 'MarkerSize', 14)
colormap(ax2, my_c)

ax2.XTick = 1 + vals_short * (n_val - 1);
ax2.XTickLabels = vals_short;
ax2.YTick = 1 + vals_short * (n_val - 1);
ax2.YTickLabels = yvals_short;
set(gca, 'FontSize', 14)
title('\tau = 2, \kappa = 1', 'FontSize', 16)

xlabel('Initiation x', 'FontSize', 16)
ylabel('Resuscitation y', 'FontSize', 16)
c = colorbar('FontSize',16);
c.Label.String = 'Lyapunov exponent';