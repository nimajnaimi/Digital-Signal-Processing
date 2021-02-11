%--------------------------Task 1:
N = -pi : 1/pi : pi;
b = [1 -2 * cos(pi / 3) 1];
[H, W] = freqz(b, 1, N);
subplot(3, 1, 1);
stem(W/pi, abs(H));
title('Theta = pi / 3');
xlabel('Digital Frequency (-pi to pi)');

b = [1 -2 * cos(pi / 6) 1];
[H, W] = freqz(b, 1, N);
subplot(3, 1, 2);
stem(W/pi, abs(H));
title('Theta = pi / 6');
xlabel('Digital Frequency (-pi to pi)');

b = [1 -2 * cos(pi / 2) 1];
[H, W] = freqz(b, 1, N);
subplot(3, 1, 3);
stem(W/pi, abs(H));
title('Theta = pi / 2');
xlabel('Digital Frequency (-pi to pi)');

load speech1.mat;
%sound(speech1, 8000);
n = 1001: 1100;
figure;
subplot(2, 1, 1);
plot(n, speech1(n));
title('Time Domain Representation of Unfiltered Speech Signal');
xlabel('Sample Number');

x = speech1(101:1100);
[X,w] = dtft(x, length(x));

subplot(2, 1, 2);
plot(w / pi, abs(X));
title('Digital Frequency Content of Unfiltered Speech Signal');
xlabel('Digital Frequency (-pi to pi)');

[Xmax, Imax] = max(abs(X));
y = FIRfilter(speech1, w(Imax));

yy = y(101:1100);
[Y,w] = dtft(yy, length(yy));
figure;
plot(w / pi, abs(Y));
title('Plot of Filtered Signal');
xlabel('Digital Frequency (-pi to pi)');

%sound(y, 8000);

%--------------------------Task 2:
r = 0.7;
theta = pi / 3;
a = [1 , 2 * r * cos(theta) , r * r];
figure;
subplot(3, 1, 1);
[H, W] = freqz(1, a);
plot(W / pi, 20*log10(abs(H)));
title('Plot of IIR Filter With r = 0.7');
xlabel('Digital Frequency (0 to pi)');

r = 0.9;
a = [1 , 2 * r * cos(theta) , r * r];
subplot(3, 1, 2);
[H, W] = freqz(1, a);
plot(W / pi, 20*log10(abs(H)));
title('Plot of IIR Filter With r = 0.9');
xlabel('Digital Frequency (0 to pi)');

r = 0.99;
a = [1 , 2 * r * cos(theta) , r * r];
subplot(3, 1, 3);
[H, W] = freqz(1, a);
plot(W / pi, 20*log10(abs(H)));
title('Plot of IIR Filter With r = 0.99');
xlabel('Digital Frequency (0 to pi)');

load pcm.mat;
%sound(pcm, 8000);

figure;
subplot(2, 1, 1);
plot(n, pcm(n)); %n = 1001: 1100;
title('Time Domain Representation of Unfiltered Audio Signal');
xlabel('Sample Number');

y = pcm(101:1100);
[Y,w] = dtft(pcm, length(y));

subplot(2, 1, 2);
plot(w / pi, abs(Y));
title('Frequency Domain Representation of Unfiltered Audio Signal');
xlabel('Digital Frequency (-pi to pi)');

mod_freq = 3146;
theta = mod_freq * 2 * pi / 8000;
Y_filt = IIRfilter(pcm, theta);

figure;
subplot(2, 1, 1);
plot(1001:1100, Y_filt(1001:1100));
title('Time Domain Representation of Filtered Audio Signal');
xlabel('Sample Number');

y_filt = Y_filt(101:1100);
[YY,w] = dtft(Y_filt, length(y_filt));
subplot(2, 1, 2);
plot(w / pi, abs(YY));
title('Frequency Domain Representation of Filtered Audio Signal');
xlabel('Digital Frequency (-pi to pi)');

%sound(Y_filt, 8000);

figure;
plot(w, abs(YY));
xlim([theta - 0.02, theta + 0.02]);
title('Zoomed Plot of DTFT of Filtered Signal');
