%Takes environmentla input 0,1 vector and returns the distribution of 
%0 in the vector (bad environment)
function dist = bad_len_dist_fct(env)
curr_length = 0;
dist_ind = 1;
for i = 2:length(env)
    if env(i) == 0
        if env(i-1) == 0
            curr_length = curr_length + 1;
        else
            curr_length = 1;
        end
        
        if i == length(env)
            dist(dist_ind) = curr_length;
        end
    else
        if env(i-1) == 0
            dist(dist_ind) = curr_length;
            dist_ind = dist_ind + 1;
            curr_length = 0;
        end
    end
end
end