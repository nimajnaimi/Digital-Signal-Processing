% 5. c. Plot the magnitude response of the frequency responses in obtained
% in (a) and (b) using MATLAB. (Hint: use the function freqz)
% MATLAB. (Hint: use the function freqz)
a = 1;
b = [1/5, 1/5, 1/5, 1/5, 1/5];
freqz(b, a);
a2 = [1 , -0.5772, 0.4218, -0.0563];
b2 = [0.0985, 0.2956, 0.2956, 0.0985];
figure;
freqz(b2, a2);

% 6.b. Compute the FFT of x[n] with an FFT size N=30, and plot the 
% magnitude of the FFT of the signal in the frequency range of -fs/2 to 
% fs/2. (Hint: use fftshift)
Fs = 1500;
T = 1/Fs;
N = 30;
t = (0:N-1)*T;
f_1 = 100;
f_2 = 500;
X = cos(2*f_1*pi*t) + cos(2*f_2*pi*t);
X_fft = fft(X);
fftshift(X_fft);
fshift = (-N/2:N/2-1)*(Fs/N);
figure;
plot(fshift, abs(X_fft));

% 6.d. Plot the magnitude of the FFT of the output signal y[n] that is 
% obtained when x[n] is filtered by passing it through the system whose 
% difference equation is given by given question #4(b). Use the same 
% frequency range as (b).
a3 = 1;
b3 = [0.25, 0.5, 0.25];
Y = filter(b3, a3, X);
Y_fft = fft(Y);
fftshift(Y_fft);
fshift = (-N/2:N/2-1)*(Fs/N);
figure;
plot(fshift, abs(Y_fft));

% 6.f. Repeat (b), if f1= 480 and f2=500. Can you tell the frequencies of 
% the signal from your plot? Why?
f_1 = 480;
f_2 = 500;
X = cos(2*f_1*pi*t) + cos(2*f_2*pi*t);
X_fft = fft(X);
fftshift(X_fft);
fshift = (-N/2:N/2-1)*(Fs/N);
figure;
plot(fshift, abs(X_fft));

