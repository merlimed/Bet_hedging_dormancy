% returns pdf for n events with different probabilities called rates and 
% k occurences 
function final_dist = transition_time_dist(rates, n)
    k = length(rates);
    final_dist = zeros(n, 1);
    for i = k:n
        final_dist(i) = prod(rates) * multinomial(1 - rates, i - k);
    end    
end