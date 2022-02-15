%Stochastic dormany function
%This function takes in init_v meaning how many cells are in each state
%from A - D1 - D2 -...- Dn, env parameters of length n and parameters pars
function w_final = per_state_dorm_fct(init_v, env, pars)
    n_t = length(pars.t); %total number of states
    w_final = -1 * ones(n_t, pars.n); %number of steps at every step
    
    %initial conditions
    %split initial number of cells half in A and half split equally among Dn
    init_v_adjusted = init_v / 2;
    x = init_v_adjusted / (n_t - 1) * ones(1, n_t);
    x(1) = init_v_adjusted;
    
    % env_con is the environmental condition for all states and all days
    % env_con[i, :] is the environmental condition for day i and all states
    env_con = -1 * ones(n_t, length(env));
    for i = 1:n_t
        env_con(i, :) = env * (1 - pars.w) + pars.w;
    end
    % this is the env condition for the active cells
    env_con(1, :) = pars.r * (env * (1 - pars.w/pars.r) + pars.w/pars.r);
    % this is the env condition for the dormant cells
    env_con(end, :) = pars.lam * ones(1, length(env));
    w_final(:, 1) = x;
    for i = 1 : (pars.n - 1)
        x = x .* (1 - pars.t) + circshift(x, 1) .* circshift(pars.t, 1);
        x = env_con(:, i + 1).' .* x;
        w_final(:, i + 1) = x;
    end
end