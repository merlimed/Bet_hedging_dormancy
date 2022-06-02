%Takes environmentla input 0,1 vector and returns the distribution of 
%1 in the vector (good environment)
function dist = good_len_dist_fct(env)
curr_length = 0;
dist_ind = 1;
for i = 2:length(env)
    %if now is good
    if env(i) == 1
        %if yesterday was also good increase curr len
        if env(i-1) == 1
            curr_length = curr_length + 1;
        %otherwise curr len is 1
        else
            curr_length = 1;
        end
        %if we are at the end we're done!
        if i == length(env)
            dist(dist_ind) = curr_length;
        end
    % if today is bad we add currlen and reset it
    else
        if env(i-1) == 1
            dist(dist_ind) = curr_length;
            dist_ind = dist_ind + 1;
            curr_length = 0;
        end
    end
end
end