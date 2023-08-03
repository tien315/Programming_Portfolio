function [y, ind] = mymin(x)
    y = x(1);
    ind = 1;
    for i = 2:length(x)
        if x(i) < y
            y = x(i);
            ind = i;
        end
    end
end
