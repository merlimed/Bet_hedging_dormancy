function y = prob_dist(len)
y = -1 * ones(2, 7);

if len > 3
    len_vals = [len-3, len-2, len-1, len, len+1, len+2, len+3];
    len_prob = [1, 2, 3, 4, 3, 2, 1];
    
elseif len == 3
    len_vals = [1, 2, 3, 4, 5, 6, 7];
    len_prob = [3.2, 3.6, 4, 2.7, 1.6, .7, .5];

elseif len == 2 
    len_vals = [1, 2, 3, 4, 5, 6, 7];
    len_prob = [17, 19, 2.5, 2, 1.5, 1, 0.5];
end

len_prob = len_prob / sum(len_prob);
y(1, :) = len_vals;
y(2, :) = len_prob; 
end
   