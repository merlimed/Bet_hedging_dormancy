clc
clear

pars.r = 2; % reproduction rate during good times
pars.p = 0.5; % overall probability of a bad event
pars.n = 50; % number of events
pars.w = .5; % percentage of A and transition states which survives during bad times
pars.lam = 1; % survival of dormant during good/ bad times
pars.init_v = 10^2;
save('Data/parameters.mat','pars')
