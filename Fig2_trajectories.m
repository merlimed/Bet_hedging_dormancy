% This script computes the population dynamics for stochastic bethedging
% with x = y and env with average duration of good = bad = 2
clc
clear
addpath Functions
load 'Data/parameters.mat'
%% 
% We compute the trajectories for different values of dormancy initiation
% and resuscitaiton pairs (x,y) where x = y
n_vals = 11; % number of xy pairs
xy_vals = linspace(0, 1, n_vals); % values of dorm transition probabilities
t_dyn = zeros(n_vals, pars.n); % time trajectories for all values of x=y

L_vals = 5 * ones(1, n_vals);  %lyapunov value to be computed
%initial conditions such that no two values are equal and they are all
%negative so that the find() function works well
for i = 1 : n_vals
    L_vals(i) = i - 100;
end

%while the max is not obtained in the middle
while find(L_vals == max(L_vals)) ~= ((n_vals - 1)/2 + 1)
    env = env_gamma(2, 2, 1, 1, pars.n); %simulate environment 
    for i = 1 : n_vals
        pars.t = xy_vals(i) * ones(1, 2); %value of dormancy transition prob (x,y)
        t_dyn(i, :) = stochastic_fct(env, pars); %calculate trajectory
        L_vals(i) =  Lyapunov_fct(t_dyn(i, :)); % calculate Lyapunov exponent
    end
end
%%
switch_env = {1};
for i = 2:pars.n
    if env(i)+ env(i-1) == 1
        switch_env = [switch_env, i];
    end
end     
switch_env = [switch_env, pars.n+1];
switch_env = cell2mat(switch_env);
%%
figure('Position', [100 100 1100 450])
subplot(1,2,1)
hold on
max_val = 2 * max(max(t_dyn));
% Colors for the plots
pretty_green = [213, 236, 190]/255; 
pretty_red = [242, 181, 178]/255;
white = [1, 1, 1];
gray = [.85, .85, .85];

%plot the green and red polygons
for i = 1:length(switch_env)-1
    if mod(i, 2) == 1
        a = area([switch_env(i)-1 switch_env(i+1)-1], [max_val max_val], 'FaceColor', pretty_green, ...
        'LineStyle', 'none');
        a.Annotation.LegendInformation.IconDisplayStyle = 'off';
        alpha(a, .9)
    else
        a = area([switch_env(i)-1 switch_env(i+1)-1], [max_val max_val], 'FaceColor', pretty_red, ...
        'LineStyle', 'none');
        a.Annotation.LegendInformation.IconDisplayStyle = 'off';
        alpha(a, .8)
    end
end
%plot 3 trajectories for .1, .5, .9
ind1 = find(xy_vals>= .1, 1);
ind2 = find(xy_vals>= .5, 1);
ind3 = find(xy_vals>= .9, 1);
plot(1:pars.n, t_dyn(ind1,:), 'LineWidth', 3, 'Color', [0, 0.247, 0.941])
plot(1:pars.n, t_dyn(ind2,:), 'LineWidth', 3, 'Color', [0, 0.447, 0.741])
plot(1:pars.n, t_dyn(ind3,:), 'LineWidth', 3, 'Color', [0.301, 0.745, 0.933])
legend('x = y = .1','x = y = .5', 'x = y = .9', 'location', 'SE')
ylim([10^1*5, max_val])
set(gca, 'Fontsize', 16)
set(gca, 'YScale', 'log')
xlabel('Time')
ylabel('Population Size')

subplot(1,2,2)
hold on
% plot zero line
plot(linspace(0-0.05, 1+0.05, 11), zeros(1,11), 'k--', 'LineWidth',1.5, 'HandleVisibility','off')
% plot all Lyapunov values
plot(xy_vals, L_vals, 'x', 'LineWidth', 2, 'MarkerSize', 16, 'Color', [.7, .7, .7],'HandleVisibility','off')
% emphasize the Lyapunov values for previously plotted trajectories  
plot(xy_vals(ind1), L_vals(ind1), 'x', 'LineWidth', 3, 'MarkerSize', 16, 'Color', [0, 0.247, 0.941]);
plot(xy_vals(ind2), L_vals(ind2), 'x', 'LineWidth', 3, 'MarkerSize', 16, 'Color', [0, 0.447, 0.741]);
plot(xy_vals(ind3), L_vals(ind3), 'x', 'LineWidth', 3, 'MarkerSize', 16, 'Color', [0.301, 0.745, 0.933])
xlim([0-0.05, 1+.05])
ylim([min(L_vals)-0.005, max(L_vals)+0.005])
legend('x = y = .1','x = y = .5', 'x = y = .9', 'location', 'S', 'Box','off')
set(gca, 'Fontsize', 16)
xlabel('Switching probability (x = y)')
ylabel('Lyapunov exponent')

            
            
            