%Stochastic dormany function
%This function takes in init_v meaning how many cells are in each state
%from A - D1 - D2 -...- Dn, env parameters of length n and parameters pars
function w_final = stochastic_fct(env, pars)
    w_final = -1 * ones(1, pars.n); %number of steps at every step
    n_t = length(pars.t); %total number of states
    
    %initial conditions
    %split initial number of cells half in A and half split equally among
    %Dormant states
    init_v_adjusted = pars.init_v / 2;
    x = init_v_adjusted / (n_t - 1) * ones(1, n_t);
    x(1) = init_v_adjusted;
    
    % env_con is the environmental condition for all states and all days
    % env_con[i, :] is the environmental condition for day i and all states
    env_con = -1 * ones(n_t, length(env));
    % this is the env condition for the transitioning D_i cells
    % 1 if env = 1 and w if env = 0
    for i = 1 : n_t
        env_con(i, :) = env * (1 - pars.w) + pars.w;
    end
    % this is the env condition for the active cells
    % r if env = 1 and w if env = 0
    env_con(1, :) = pars.r * (env * (1 - pars.w/pars.r) + pars.w/pars.r);
    
    % this is the env condition for the dormant cells
    % pars.lam regardless of env value
    env_con(end, :) = pars.lam * ones(1, length(env));
    w_final(1) = sum(x);
    
    %update population values based on env_con
    for i = 1 : (pars.n - 1)
        %(1-t) stay in the same place and t come from the previous state
        x = x .* (1 - pars.t) + circshift(x, 1) .* circshift(pars.t, 1);
        %cells grow and die based on env_con
        x = env_con(:, i + 1).' .* x;
        w_final(i + 1) = sum(x);
    end
end