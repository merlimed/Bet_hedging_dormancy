clc
clear
addpath Functions
% Here we will compute the final abundancy for 0, 5, 10 and 20 transition states
% We will do so for all values of x and y between 0 and 1 while keeping everything else fixed
%Define variables and parameters
pars.r = 2; % reproduction rate during good times
pars.p = 0.5; % overall probability of a bad event
pars.n = 50; % number of events
pars.w = .5; % percentage of A and transition states which survives during bad times
pars.lam = 1; % survival of dormant during good/ bad times

init_v = 10^2; %initial number of cells
%%
num_t = 21; % number of xy pairs
yvals = -5 * ones(1,num_t);  %lyapunov constst
for i=1:num_t
    yvals(i) = i-100;
end
t_dyn = zeros(num_t, pars.n); % time trajectories for all values of x=y
while find(yvals == max(yvals)) ~= ((num_t-1)/2+1)
    env = env_gamma(2, 2, 1, 1, pars.n);
    %values for 0,1,2,3,4,5 so 6 total
    for i=1:num_t
        t_temp = ((i-1)/(num_t-1))*ones(1,2);
        pars.t = t_temp;
        t_dyn(i, :) = stochastic_fct(init_v, env, pars);
        yvals(i) =  Lyapunov_fct(t_dyn(i,:));
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
%%
switch_env = cell2mat(switch_env);
%%
xvals = linspace(0,1,num_t);

figure('Position', [100 100 1100 450])
subplot(1,2,1)
hold on
max_val = 2 * max(max(t_dyn));
pretty_green = [213, 236, 190]/255;
pretty_red = [242, 181, 178]/255;
white = [1, 1, 1];
gray = [.85, .85, .85];


ugly_green = [213, 236, 190]/255;
ugly_red = [242, 181, 178]/255;
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
ind1 = find(xvals>= .1, 1);
ind2 = find(xvals>= .5, 1);
ind3 = find(xvals>= .9, 1);
plot(1:pars.n, t_dyn(ind1,:), 'LineWidth', 3, 'Color', [0, 0.247, 0.941])
plot(1:pars.n, t_dyn(ind2,:), 'LineWidth', 3, 'Color', [0, 0.447, 0.741])
plot(1:pars.n, t_dyn(ind3,:), 'LineWidth', 3, 'Color', [0.301, 0.745, 0.933])
legend('x = y = .1','x = y = .5', 'x = y = .9', 'location', 'SE')
ylim([10^1*5, max_val])
set(gca, 'Fontsize', 16)
set(gca, 'YScale', 'log')
xlabel('Time')
ylabel('Population Size')
%title('Population dynamics')

subplot(1,2,2)
hold on
plot(linspace(0-0.05, 1+0.05, 11), zeros(1,11), 'k--', 'LineWidth',1.5, 'HandleVisibility','off')
plot(xvals, yvals, 'x', 'LineWidth', 2, 'MarkerSize', 16, 'Color', [.7, .7, .7],'HandleVisibility','off')
plot(xvals(ind1), yvals(ind1), 'x', 'LineWidth', 3, 'MarkerSize', 16, 'Color', [0, 0.247, 0.941]);
plot(xvals(ind2), yvals(ind2), 'x', 'LineWidth', 3, 'MarkerSize', 16, 'Color', [0, 0.447, 0.741]);
plot(xvals(ind3), yvals(ind3), 'x', 'LineWidth', 3, 'MarkerSize', 16, 'Color', [0.301, 0.745, 0.933])
xlim([0-0.05, 1+.05])
ylim([min(yvals)-0.005, max(yvals)+0.005])
legend('x = y = .1','x = y = .5', 'x = y = .9', 'location', 'S', 'Box','off')
set(gca, 'Fontsize', 16)
xlabel('Switching probability (x = y)')
ylabel('Lyapunov exponent')

            
            
            