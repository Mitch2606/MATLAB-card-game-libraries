function [xArray] = removeZeros(xArray)
    i = 1;
    while(i <= length(xArray))
        if(xArray(i) == 0)
            xArray = [xArray(1:i - 1), xArray(i + 1:end)];
        else
            i = i + 1;
        end
    end


end

