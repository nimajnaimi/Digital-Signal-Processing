% Problem 1
Ws = 0.5*pi;
Wp = 0.45*pi;
M = ceil(6.6*pi/(Ws-Wp));
if (mod(M, 2) == 0)
    M = M+1;
end
Wc = (Wp+Ws)/2;
alpha = (M-1)/2;
n = 0:M-1;
h = Wc/pi * sinc(Wc/pi*(n-alpha)) .* hamming(M)';
h = firlp2hp(h);
[H, W] = freqz(h, 1);
figure('Name', 'Problem 1 - Windowed High Pass Filter');
subplot(3, 1, 1);
stem(h);
title('Impulse Response of Filter');
xlabel('Samples');
ylabel('Amplitude');
subplot(3, 1, 2);
plot(W/pi, abs(H));
title('Magnitude Response of Filter');
xlabel('Digital Frequency (0 to \pi)');
ylabel('Magnitude');
subplot(3, 1, 3);
plot(W/pi, 20*log10(abs(H)/max(abs(H))));
title('Magnitude Response of Filter in dB');
xlabel('Digital Frequency (0 to \pi)');
ylabel('Magnitude (dB)');

Rp = 0.5;
As = 53;
f = [0.45 0.5];
a = [0 1];
dev = [10^(-As/20) (10^(Rp/20)-1)/(10^(Rp/20)+1)]; 
[n, fo, ao, w] = firpmord(f, a, dev);
b = firpm(n, fo, ao, w);
[H, W] = freqz(b, 1);
figure('Name', 'Problem 1 - PM High Pass Filter');
subplot(3, 1, 1);
stem(b);
title('Impulse Response of Filter');
xlabel('Samples');
ylabel('Amplitude');
subplot(3, 1, 2);
plot(W/pi, 20*log10(abs(H)/max(abs(H))));
title('Magnitude Response of Filter in dB');
xlabel('Digital Frequency (0 to \pi)');
ylabel('Magnitude (dB)');
subplot(3, 1, 3);
plot(W/pi, abs(H));
title('Magnitude Response of Filter');
xlabel('Digital Frequency (0 to \pi)');
ylabel('Magnitude');

% Problem 2
Fs = 100000;
Wp = 2 * tan(12000*2*pi/(2*Fs));
Rp = 3;
Ws = 2 * tan(20000*2*pi/(2*Fs));
As = 35;
Wr = Ws / Wp;
E = sqrt((10^(Rp/10)) - 1);
A = 10^(As/20);
alpha = 1/E + sqrt(1 + (1/E^2));
g = sqrt(((A^2)-1) / (E^2));
n = ceil(log10(g + sqrt(g^2 - 1)) / log10(Wr + sqrt(Wr^2 - 1))) + 10;
a = 0.5 * (alpha^(1/n) - (1/alpha)^(1/n));
b = 0.5 * (alpha^(1/n) + (1/alpha)^(1/n));
if (mod(n, 2) == 0)
    K = 1/sqrt(1+E^2); % Filter order is even
else
    K = 1;
end
k = 0:n-1;
rk = (a*Wc) * cos(pi/2 + (2*k+1)*pi/(2*n));
wk = (b*Wc) * sin(pi/2 + (2*k+1)*pi/(2*n));
pk = rk + j*wk;
index = find(real(pk) < 0);
pk = pk(index);
a = real(poly(pk));
[bz, az] = bilinear(K, a, Fs);
[H, W] = freqs(K, a);
figure;
plot(W*Fs/(2*pi), 20*log10(abs(H)));

N = 1024;
t = (0:N)/Fs;
x = sin(8000*2*pi*t) + sin(40000*2*pi*t);
fshift = (-N/2:N/2-1)*(Fs/N);
figure;
subplot(4, 1, 3);
plot(fshift, abs(fftshift(fft(x, 1024))));
title('Magnitude of DFT of Unfiltered Signal');
xlabel('Frequency (Hz)');
y = filter(bz, az, x);
subplot(4, 1, 4);
plot(fshift, abs(fftshift(fft(y, 1024))));
title('Magnitude of DFT of Filtered Signal');
xlabel('Frequency (Hz)');

% Problem 3
Fs = 10000;
Rp = 1;
As = 30;
Wp = [2*1000/Fs 2*4000/Fs];
Ws = [2*1500/Fs 2*3500/Fs];
[N, Wn] = buttord(Wp, Ws, Rp, As);
[b, a] = butter(N, Wn, 'stop');
filt(b, a)
[H, W] = freqz(b, a);
figure('Name', 'Problem 3 - Butterworth Bandstop Filter');
subplot(3, 1, 1);
plot(W*Fs/(2*pi), abs(H));
title('Magnitude Response of Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(3, 1, 2);
plot(W*Fs/(2*pi), 20*log10(abs(H)));
title('Magnitude Response of Filter in dB');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
subplot(3, 1, 3);
plot(W*Fs/(2*pi), angle(H));
title('Phase Response of Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
N = 1024;
t = (0:N)/Fs;
x = sin(800*2*pi*t) + sin(2800*2*pi*t) + sin(4500*2*pi*t);
fshift = (-N/2:N/2-1)*(Fs/N);
figure('Name', 'Problem 3 - Singal Filtering');
subplot(2, 1, 1);
plot(fshift, abs(fftshift(fft(x, 1024))));
title('Magnitude of DFT of Unfiltered Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
y = filter(b, a, x);
subplot(2, 1, 2);
plot(fshift, abs(fftshift(fft(y, 1024))));
title('Magnitude of DFT of Filtered Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');