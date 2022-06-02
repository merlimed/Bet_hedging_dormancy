%This simple functions returns the lyapunov exponent of a population w
function y = Lyapunov_fct(w)
y = log(w(end) / w(1))/length(w);
end