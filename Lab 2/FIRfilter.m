function [x] = FIRfilter(X, tone_freq)
    b = [1 -2 * cos(tone_freq) 1];
    x = filter(b, 1, X);
end