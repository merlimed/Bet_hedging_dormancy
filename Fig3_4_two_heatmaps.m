clc
clear
addpath Functions
%%
%Define variables and parameters
pars.r = 2; % reproduction rate during good times
pars.p = 1/2; % overall probability of a bad event
pars.n = 500; % number of events
pars.w = .5; % percentage of A and transition states which survives during bad times
pars.lam = 1; % survival of dormant during good/ bad times
theoretical_opt = pars.p * pars.r(pars.r-pars.lam) - (1-pars.p)*pars.w/(pars.lam-pars.w);
n_runs = 500;
init_v = 10^2;
vals = linspace(0, 1, 41);
vals_short = linspace(0, 1, 11); % values for x and y
n_val = length(vals); %tick values for x and y

%%
tic
mu_G = 2;
mu_B = 2;
k_G = 1;
k_B = 1;
L_fin = zeros(n_val, n_val);
L_fin_delay = zeros(n_val, n_val);
for i_run = 1:n_runs
    env = env_gamma(mu_G, mu_B, k_G, k_B, pars.n);
    t = ones(1, 2);
    t_delay = ones(1, 3);
    for i_x = 1:n_val
        for i_y = 1:n_val
            t(1) = vals(i_x);
            t(end) = vals(i_y);
            t_delay(1) = vals(i_x);
            t_delay(end) = vals(i_y);
            pars.t = t;

            temp = Lyapunov_fct(stochastic_fct(init_v, env, pars));
            L_fin(i_x, i_y) = L_fin(i_x, i_y) + temp;
            
            pars.t = t_delay;
            temp = Lyapunov_fct(stochastic_fct(init_v, env, pars));
            L_fin_delay(i_x, i_y) = L_fin_delay(i_x, i_y) + temp;
        end
    end
end
L_fin = L_fin / n_runs;
L_fin_delay = L_fin_delay / n_runs;
toc
beep
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
hold on 
plot(y0_max, n_val +1 - x0_max, 'rx', 'LineWidth', 3, 'MarkerSize', 14)

set(ax1, 'FontSize', 14)
ax1.XTick = 1 + vals_short * (n_val - 1);
ax1.YTick = 1 + vals_short * (n_val - 1);
ax1.XTickLabels = vals_short;
ax1.YTickLabels = yvals_short;
title('\tau = 2, n = 0, m = 1', 'FontSize', 16)
xlabel('Initiation x', 'FontSize', 16)
ylabel('Resuscitation y', 'FontSize', 16)
c = colorbar('FontSize',16);
c.Label.String = 'Lyapunov exponent';

subplot(1,2,2)
ax2 = gca;
clims = [0, max(max(L_fin_delay))];
imagesc(ax2, flipud(L_fin_delay), clims);
hold on
plot(y1_max, n_val + 1 - x1_max, 'rx', 'LineWidth', 3, 'MarkerSize', 14)

ax2.XTick = 1 + vals_short * (n_val - 1);
ax2.XTickLabels = vals_short;
ax2.YTick = 1 + vals_short * (n_val - 1);
ax2.YTickLabels = yvals_short;
set(gca, 'FontSize', 14)
title('\tau = 2, n = 1, m = 1', 'FontSize', 16)

xlabel('Initiation x', 'FontSize', 16)
ylabel('Resuscitation y', 'FontSize', 16)
c = colorbar('FontSize',16);
c.Label.String = 'Lyapunov exponent';
