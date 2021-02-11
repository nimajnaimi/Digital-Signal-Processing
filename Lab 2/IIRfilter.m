function [y] = IIRfilter(x, theta)
    r = 0.995;
    y = zeros(1, length(x));
    for n = 3 : length(x)
        y(n) = x(n) + (2 * r * cos(theta)) * y(n - 1) - r^2 * y(n - 2);
    end    
end