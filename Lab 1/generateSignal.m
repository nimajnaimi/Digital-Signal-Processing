function [x] = generateSignal(frequency, sampleRate, duration)
    N = duration * sampleRate;
    n = 0 : N-1;
    x = cos(2 * pi * frequency * n / sampleRate);
end