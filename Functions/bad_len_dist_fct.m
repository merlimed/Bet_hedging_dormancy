%Takes environmentla input 0,1 vector and returns the distribution of 
%0 in the vector (bad environment)
function dist = bad_len_dist_fct(env)
curr_length = 0; % current residence time of bad environments
dist_ind = 1;
for i = 2:length(env)
    if env(i) == 0
        if env(i-1) == 0
            curr_length = curr_length + 1; % add one if previous was bad
        else
            curr_length = 1; % reset to 1 if previous was good
        end
        
        if i == length(env)
            dist(dist_ind) = curr_length; % if we reach the end save curr_length
        end
    else
        if env(i-1) == 0
            % when we first reach good env save length of bad residence
            % time
            dist(dist_ind) = curr_length; 
            dist_ind = dist_ind + 1; %increment index
            curr_length = 0; %reset length
        end
    end
end
end