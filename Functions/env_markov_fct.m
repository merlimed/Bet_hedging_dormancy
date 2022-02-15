%first time is good and then memory one
function env = env_markov_fct(alpha, beta, n)
env = ones(1, n) ;

for i = 1:n-1
    temp = env(i); %this is the memory of the markov chain
    r_env = rand;
    %if env is good and swithing happens
    if (temp == 1) && (alpha > r_env) 
        env(i + 1) = 0;
    end
    %if env is bad and we stay there
    if (temp == 0) && (1 - beta > r_env)
        env(i + 1) = 0;
    end
end

end