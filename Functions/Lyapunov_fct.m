function y = Lyapunov_fct(w)
y = log(w(end) / w(1))/length(w);
end