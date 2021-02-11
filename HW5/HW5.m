% Problem 1:
Wp = 0.45;
Ws = 0.5;
Rp = 0.5;
As = 60;

[N, Wn] = buttord(Wp, Ws, Rp, As);
[b, a] = butter(N, Wn);
[H, W] = freqz(b, a);
figure('Name', 'Problem 1 - Butterworth');
subplot(2, 1, 1);
plot(W/pi, mag2db(abs(H)));
grid;
subplot(2, 1, 2);
grpdelay(b, a);

[N, Wp] = cheb1ord(Wp, Ws, Rp, As);
[b, a] = cheby1(N, Rp, Wp);
[H, W] = freqz(b, a);
figure('Name', 'Problem 1 - Chebyshev 1');
subplot(2, 1, 1);
plot(W/pi, mag2db(abs(H)));
grid;
subplot(2, 1, 2);
grpdelay(b, a);

[N, Ws] = cheb2ord(Wp, Ws, Rp, As);
[b, a] = cheby2(N, As, Wp);
[H, W] = freqz(b, a);
figure('Name', 'Problem 1 - Chebyshev 2');
subplot(2, 1, 1);
plot(W/pi, mag2db(abs(H)));
grid;
subplot(2, 1, 2);
grpdelay(b, a);

[N, Wp] = ellipord(Wp, Ws, Rp, As);
[b, a] = ellip(N, Rp, As, Wp);
[H, W] = freqz(b, a);
figure('Name', 'Problem 1 - Elliptic');
subplot(2, 1, 1);
plot(W/pi, mag2db(abs(H)));
grid;
subplot(2, 1, 2);
grpdelay(b, a);

% Problem 2:
rp = 0.01;
Rp = 40*log10((1+rp)/(1-rp));
Ws = [0.35 0.65];
Wp = [0.25 0.75];
[N, Wp] = cheb1ord(Wp, Ws, Rp, As);
[b, a] = cheby1(N, Rp, Wp,'stop');
[sos, g] = tf2sos(b, a);
[H, W]= freqz(b, a);
figure('Name', 'Problem 2');
subplot(2, 1, 1);
plot(W/pi, abs(H));
grid;
subplot(2, 1, 2);
plot(W/pi, mag2db(abs(H)));
grid;

% Problem 3:
fs = 10000;
Ws = 1500;
As = 40;
Wp = 2000;
Rp = 1;
[n, Wp] = ellipord(Wp, Ws, Rp, As, 's');
[b, a] = ellip(n, Rp, As, Wp, 'high', 's');
[H, W] = freqs(b, a);
figure('Name', 'Problem 3');
subplot(2, 1, 1);
plot(W, abs(H));
grid;
xlim([0 5000]);
Wp = 2*tan(Wp*2*pi/fs/2);
Ws = 2*tan(Ws*2*pi/fs/2);
[n, Wp] = ellipord(Wp, Ws, Rp, As, 's');
[b, a] = ellip(n, Rp, As, Wp, 'high', 's');
[b, a] = bilinear(b, a, 1);
[H, W] = freqz(b, a);
subplot(2, 1, 2);
plot(W/pi, abs(H));
grid;