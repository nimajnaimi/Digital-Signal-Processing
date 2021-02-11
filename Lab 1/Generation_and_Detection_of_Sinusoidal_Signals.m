dialedNumbers = ['7'];
duration = 0.5;
sampleRate = 8000;
N = 1024;
y = DTMFGenerate(dialedNumbers, sampleRate, duration);
yy = fftshift(fft(y, 1024));
Wd = -sampleRate / 2 : sampleRate / N : (sampleRate / 2 - sampleRate / N);
stem(Wd, abs(yy));
xlabel('Frequency (Hz)');

dialedNumbers = ['1' '2' '3' '5' '6' '7' '8'];
sampleRate  = 8000;
duration  = 0.1;
x = DTMFGenerate(dialedNumbers, sampleRate, duration);
%sound(x, 8000);

dialedNumbers = ['1' '5' '4' '8'];
N = 1024;
duration = 0.1;
sampleRate = 8000;
x = DTMFGenerate(dialedNumbers, sampleRate, duration);
z = DTMFDetector(x, N, sampleRate, duration);




