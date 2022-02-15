%This function computes the probability that length(rates) events with 
%probabilities rates yield j correct events
%rates. size is k
function y = multinomial(rates, j)
    if j == 0
        y = 1;
    else
        y = 0;

        rates_copy = rates;

        for i = 0:j
            if length(rates) == 1
                y = rates(1)^j;
            else
                %if first one in rates has degree i 
                rates = rates(2 : end);
                y = y + rates_copy(1)^i * multinomial(rates, j - i);
                rates = rates_copy;
            end
        end
    end
end