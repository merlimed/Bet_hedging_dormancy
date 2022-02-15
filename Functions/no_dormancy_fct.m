%No dormany function
%This function takes in init_v meaning how many cells are active
%env parameters of length n and parameters pars
function w_final = no_dormancy_fct(init_v, env, pars)
    w_final = -1 * ones(1, pars.n); %number of steps at every step
    w_final(1) = init_v;
    for i = 1:pars.n-1
        if env(i+1) == 1
            w_final(i+1) = pars.r * w_final(i);
        else
            w_final(i+1) = pars.w * w_final(i);
        end
    end
end