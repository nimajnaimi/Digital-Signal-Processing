function [number] = DTMFDetector(x, N, sampleRate, duration)
    numDigit = length(x) / (sampleRate * duration);
    fa = [697 770 852 941 1209 1336 1477];
    digit = ['1', '2', '3'; '4', '5', '6'; '7', '8', '9'; '*', '0', '#'];
    number = [];
    for i = 1 : numDigit
        divisions = x((i - 1) * (sampleRate * duration) + 1 : i * (sampleRate * duration));

        for i = 1 : length(fa)
            k(i) = round(fa(i) * N / sampleRate);
        end

        v= [];
        for i = 1 : length(fa)
            a = [1 -2 * cos(2 * pi * k(i) / N) 1];
            v = filter(1, a, [divisions,0]);
            magX(i) = v(end)^2-2*cos(2*pi*k(i)/N)*v(end)*v(end-1)+v(end-1)^2;
        end

        [Max, row] = max(magX(1 : 4));
        [Max, column] = max(magX(5 : 7));

        number = [number, digit(row, column)];
    end 
