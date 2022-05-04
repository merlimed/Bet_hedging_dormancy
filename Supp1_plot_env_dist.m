%This script simulated the residence time distribution for 4 different
%values of kappa and fix tau and compares it to the theoretical estimate 
clc
clear
env_tau = 6;
n = 5000;
%%
%fig = figure('Position', [200 300 1300 300])
t = tiledlayout(1, 4);
nexttile
kappa = 1; % kappa value
pdf_len = 20; %max value of x axis
t1 = kappa/env_tau * ones(kappa,1); % this maintains mean tau but has kappa delay
t1_pdf = transition_time_dist(t1, pdf_len); %theoretical pdf
env = env_gamma(env_tau, env_tau, kappa, kappa, n);
g_dist = good_len_dist_fct(env); % simulation pdf
hold on
histogram(g_dist, 'Normalization', 'probability')
plot(1:pdf_len, t1_pdf, 'LineWidth', 3)
plot(mean(g_dist) * ones(1,10), linspace(0,1,10),'--','Color', [0.2 0.2 0.9] ,'LineWidth', 3)

set(gca, 'Fontsize', 16)
ylabel('Probability')
ylim([0 0.45])
xlim([0 pdf_len])
title('\kappa = 1, \tau = 6')
legend('Simulation', 'Theory', 'Simulation mean')

nexttile
kappa = 2;
t2 = kappa/env_tau * ones(kappa,1);
t2_pdf = transition_time_dist(t2, pdf_len);
env = env_gamma(env_tau, env_tau, kappa, kappa, n);
g_dist = good_len_dist_fct(env);
hold on
histogram(g_dist, 'Normalization', 'probability')
plot(1:pdf_len, t2_pdf, 'LineWidth', 3)
plot(mean(g_dist) * ones(1,10), linspace(0,1,10),'--','Color', [0.2 0.2 0.9] ,'LineWidth', 3)
set(gca, 'Fontsize', 16)
title('\kappa = 2, \tau = 6')
ylim([0 0.45])
xlim([0 pdf_len])
legend('Simulation', 'Theory', 'Simulation mean')

nexttile
kappa = 4;
t4 = kappa/env_tau * ones(kappa,1);
t4_pdf = transition_time_dist(t4, pdf_len);
env = env_gamma(env_tau, env_tau, kappa, kappa, n);
g_dist = good_len_dist_fct(env);
hold on
histogram(g_dist, 'Normalization', 'probability')
plot(1:pdf_len, t4_pdf, 'LineWidth', 3)
plot(mean(g_dist) * ones(1,10), linspace(0,1,10),'--','Color', [0.2 0.2 0.9] ,'LineWidth', 3)
set(gca, 'Fontsize', 16)
ylim([0 0.45])
xlim([0 pdf_len])
title('\kappa = max-2 (4), \tau = 6')
legend('Simulation', 'Theory', 'Simulation mean')

nexttile
kappa = 5;
t5 = kappa/env_tau * ones(kappa,1);
t5_pdf = transition_time_dist(t5, pdf_len);
env = env_gamma(env_tau, env_tau, kappa, kappa, n);
g_dist = good_len_dist_fct(env);
hold on
histogram(g_dist, 'Normalization', 'probability')
plot(1:pdf_len, t5_pdf, 'LineWidth', 3)
plot(mean(g_dist) * ones(1,10), linspace(0,1,10),'--','Color', [0.2 0.2 0.9] ,'LineWidth', 3)
set(gca, 'Fontsize', 16)
ylim([0 0.45])
xlim([0 pdf_len])
title('\kappa = max - 1 (5), \tau = 6')
legend('Simulation', 'Theory', 'Simulation mean')

xlabel(t, 'Residence time', 'FontSize', 20)
%% Plot all in the same figure
len_pdf = 30;
t1 = 1/5 * ones(1,1);
t1_pdf = transition_time_dist(t1, len_pdf);
t2 = 2/5 * ones(2,1);
t2_pdf = transition_time_dist(t2, len_pdf);
t3 = 3/5 * ones(3,1);
t3_pdf = transition_time_dist(t3, len_pdf);
t4 = 4/5 * ones(4,1);
t4_pdf = transition_time_dist(t4, len_pdf);
t5 = 5/5 * ones(5,1);
t5_pdf = transition_time_dist(t5, len_pdf);
figure()
hold on
plot(1:len_pdf, t1_pdf, 'LineWidth', 3)
plot(1:len_pdf, t2_pdf, 'LineWidth', 3)
plot(1:len_pdf, t3_pdf, 'LineWidth', 3)
plot(1:len_pdf, t4_pdf, 'LineWidth', 3)
plot(1:len_pdf, t5_pdf, 'LineWidth', 3)

set(gca, 'FontSize', 16)
ylabel('Probability')