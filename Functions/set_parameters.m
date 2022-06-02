clc
clear

pars.r = 2; % reproduction rate during good times
pars.p = 0.5; % overall probability of a bad event
pars.n = 500; % number of events
pars.w = .5; % percentage of A and transition states which survives during bad times
pars.lam = 1; % survival of dormant during good/ bad times
pars.init_v = 10^2;
pars.xy_vals = linspace(0, 1, 41); % all values for x and y for figures 3-7
pars.n = 500;
pars.n_runs = 1000;
pars.xy_vals = linspace(0, 1, 41);
pars.delays = [0, 1, 2, 4, 6, 8, 10]; %parameters for figures 5-6-7 and C_ figs
pars.env_tau = [2, 4, 6, 8, 10, 20]; %parameters for figures 5-6-7 and C_ figs
pars.k_vals = ones(length(pars.delays), length(pars.env_tau));

pars.k_vals = zeros(6, 4);
%order of kappa is 1,2, max-2, max-1
pars.k_vals(1,:) = [1, -1, -1, -1]; % tau 2
pars.k_vals(2,:) = [1, 2, 2, 3]; % tau 4
pars.k_vals(3,:) = [1, 2, 4, 5];
pars.k_vals(4,:) = [1, 2, 6, 7];
pars.k_vals(5,:) = [1, 2, 8, 9];
pars.k_vals(6,:) = [1, 2, 18, 19];
save('Data/parameters.mat','pars')
