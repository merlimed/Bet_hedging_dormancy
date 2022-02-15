%stoch_temp = zeros(n_env, n_k, n_delays, 2);
clc
clear
load 'Data/stoch_opt_refined.mat'
load Data/opt_fitness.mat
%%
% order of dimensions is environment, k, delay, x y
delays = [0, 1, 2, 4, 6, 8, 10];
env_mu = [2, 4, 6, 8, 10, 20];
k_vals = [[1, -1, -1, -1]; [1, 2, 3, -1]; [1, 2, 4, 5]; [1, 2, 6, 7];...
    [1, 2, 8, 9]; [1, 2, 18, 19]];
%% Plot delay 0 against k and mu
ms = 8;
lt = '-o';
lw = 2.5;
b1 = [0, 0.4470, 0.7410];
b2 = [87, 147, 201]/255;
b3 = [140, 183, 218]/255;
b4 = [196, 218, 236]/255;
stoch_temp = stoch_temp_new;
figure('Position', [450 400 920 370])
k_index = 3;
subplot(1,2,1)
temp = reshape(stoch_temp(:,k_index,:,1), [6, 7]);

hold on

plot(delays, temp(2,:), lt, 'LineWidth', lw, 'Color', b1, 'MarkerSize', ms, ...
    'MarkerEdgeColor', b1, 'MarkerFaceColor', b1)
plot(delays, temp(3,:), lt, 'LineWidth', lw, 'Color', b2, 'MarkerSize', ms, ...
    'MarkerEdgeColor', b2, 'MarkerFaceColor', b2)
plot(delays, temp(4,:), lt, 'LineWidth', lw, 'Color', b3, 'MarkerSize', ms, ...
    'MarkerEdgeColor', b3, 'MarkerFaceColor', b3)
plot(delays, temp(5,:), lt, 'LineWidth', lw, 'Color', b4, 'MarkerSize', ms, ...
    'MarkerEdgeColor', b4, 'MarkerFaceColor', b4)

legend('\tau = 4', '\tau = 6','\tau = 8', '\tau = 10')
xlabel('Delay to reach dormancy n')
ylabel('Switching probability')
set(gca, 'Fontsize', 16)
ylim([0 .3])
xlim([0, 10])
ax = gca;
ax.XTick = delays;
ax.XTickLabels = delays;
title('Optimal switching (x*=y*)')
grid on

subplot(1,2,2)
o1 = [200, 91, 45]/255;
o2 = [210, 122, 80]/255;
o3 = [219 155 122]/255;
o4 = [231 188 166]/255;
o5 = [243 223 210]/255;
temp_opt = reshape(L_opt(:,k_index,:), [6, 7]);

%L_opt = zeros(n_env, n_k, n_delays);
hold on
plot(delays, temp_opt(2,:), lt, 'LineWidth', lw, 'Color', o1, 'MarkerSize', ms, ...
    'MarkerEdgeColor', o1, 'MarkerFaceColor', o1)
plot(delays, temp_opt(3,:), lt, 'LineWidth', lw, 'Color', o2, 'MarkerSize', ms, ...
    'MarkerEdgeColor', o2, 'MarkerFaceColor', o2)
plot(delays, temp_opt(4,:), lt, 'LineWidth', lw, 'Color', o3, 'MarkerSize', ms, ...
    'MarkerEdgeColor', o3, 'MarkerFaceColor', o3)
plot(delays, temp_opt(5,:), lt, 'LineWidth', lw, 'Color', o4, 'MarkerSize', ms, ...
    'MarkerEdgeColor', o4, 'MarkerFaceColor', o4)
legend('\tau = 4', '\tau = 6','\tau = 8', '\tau = 10')
xlabel('Delay to reach dormancy n')
ylabel('Expected Lyapunov exponent')
set(gca, 'Fontsize', 16)
ylim([0 .15])
xlim([0, 10])
ax = gca;
ax.XTick = delays;
ax.XTickLabels = delays;
title('Optimal fitness')
grid on
