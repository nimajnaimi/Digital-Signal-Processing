function [x] = DTMFGenerate(dialedNumbers, sampleRate, duration)
    row = [697 697 697 770 770 770 852 852 852 941 941 941];
    column = [1209 1336 1477 1209 1336 1477 1209 1336 1477 1209 1336 1477 ];
    number = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '*', '0', '#'];
    x = [];
    for i = 1 : length(dialedNumbers)
        index = find(number == dialedNumbers(i));
        x = [x generateSignal(row(index), sampleRate, duration)+ ... 
        generateSignal(column(index), sampleRate, duration)];
    end
end