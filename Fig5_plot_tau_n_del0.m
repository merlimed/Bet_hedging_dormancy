clc
clear
load 'Data/stoch_opt_refined.mat'
%%
% order of dimensions is environment, k, delay, x y
delays = [0, 1, 2, 4, 6, 8, 10];
env_mu = [2, 4, 6, 8, 10, 20];
k_vals = [[1, -1, -1, -1]; [1, 2, 3, -1]; [1, 2, 4, 5]; [1, 2, 6, 7];...
    [1, 2, 8, 9]; [1, 2, 18, 19]];
%% Plot delay 0 against k and mu
stoch_temp = stoch_temp_new;
% Define colors and plot parameters
b1 = [0, 0.4470, 0.7410];
b2 = [87, 147, 201]/255;
b3 = [140, 183, 218]/255;
b4 = [196, 218, 236]/255;
gray = [.1 .1 .1];
ms = 9;
lt = '-o';
figure('Position', [230 230 920 370])
del_index = 1;
subplot(1,2,1)
hold on 
plot(env_mu, 1./env_mu, '--', 'LineWidth', 2.5, 'Color', [0 0 1 .7])
plot(env_mu, stoch_temp(:,1,del_index,1), lt,'LineWidth', 2, ...
    'MarkerEdgeColor', b1, 'MarkerFaceColor', b1, 'MarkerSize', ms, ...
    'Color', b1)
plot(env_mu, stoch_temp(:,2,del_index,1), lt,'LineWidth', 2, ...
    'MarkerEdgeColor', b2, 'MarkerFaceColor', b2 ,'MarkerSize', ms, ...
    'Color', b2)
plot(env_mu, stoch_temp(:,3,del_index,1), lt,'LineWidth', 2,...
    'MarkerEdgeColor', b3, 'MarkerFaceColor', b3, 'MarkerSize', ms, ...
    'Color', b3)
plot(env_mu, stoch_temp(:,4,del_index,1), lt,'LineWidth', 2, ...
    'MarkerEdgeColor', b4, 'MarkerFaceColor', b4,'MarkerSize', ms, ...
    'Color', b4)

legend('inverse estimate', '\kappa = 1', '\kappa = 2','\kappa = max-2', ...
    '\kappa = max-1')
xlabel('Mean residence time \tau')
ylabel('Switching probability')
set(gca, 'Fontsize', 16)
ylim([0 .5])
xlim([2, 20])
ax = gca;
ax.XTick = env_mu;
ax.XTickLabels = env_mu;

title('Optimal switching (x* = y*)')
grid on
% order of dimensions is environment, k, delay, x y
subplot(1,2,2)
o0 = [0.800, 0.17, 0.035];
o1 = [200, 91, 45]/255;
o2 = [210, 122, 80]/255;
o3 = [219 155 122]/255;
o4 = [231 188 166]/255;
o5 = [243 223 210]/255;
hold on
plot(1:4, stoch_temp(1,:,del_index,2),'o', 'LineWidth', 2,...
    'MarkerSize', ms, 'MarkerFaceColor', o0, 'MarkerEdgeColor', o0)
plot(1:4, stoch_temp(2,:,del_index,2), lt, 'LineWidth', 2, 'Color', o1, ...
    'MarkerSize', ms, 'MarkerFaceColor', o1, 'MarkerEdgeColor', o1)
plot(1:4, stoch_temp(3,:,del_index,2), lt,'LineWidth', 2, 'Color', o2, ...
    'MarkerSize', ms, 'MarkerFaceColor', o2, 'MarkerEdgeColor', o2)
plot(1:4, stoch_temp(4,:,del_index,2), lt, 'LineWidth', 2, 'Color', o3, ...
    'MarkerSize', ms, 'MarkerFaceColor', o3, 'MarkerEdgeColor', o3)
plot(1:4, stoch_temp(5,:,del_index,2), lt, 'LineWidth', 2, 'Color', o4, ...
    'MarkerSize', ms, 'MarkerFaceColor', o4, 'MarkerEdgeColor', o4)
plot(1:4, stoch_temp(6,:,del_index,2), lt, 'LineWidth', 2, 'Color', o5, ...
    'MarkerSize', ms, 'MarkerFaceColor', o5, 'MarkerEdgeColor', o5)

legend('\tau = 2', '\tau = 4','\tau = 6', ...
    '\tau = 8', '\tau = 10', '\tau = 20')
xlabel('Minimum residence time \kappa')
ylabel('Switching probability')
set(gca, 'Fontsize', 16)
ylim([0 .5])
xlim([1, 4])
ax = gca;
ax.XTick = 1:4;
ax.XTickLabels = ["1"; "2"; "max-2"; "max-1"];
title('Optimal switching (x* = y*)')
grid on