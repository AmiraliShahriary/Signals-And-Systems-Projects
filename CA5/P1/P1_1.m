clc;
clear;
close all;

t1 = 0:0.05:0.95;
x1 = exp(1i * 2 * pi * 5 * t1) + exp(1i * 2 * pi * 8 * t1);
y1 = fftshift(fft(x1));
f1 = -10:1:9;

figure;
subplot(2, 2, 1);
plot(f1, abs(y1));
xlabel('Frequency');
ylabel('F(x1)');
title('Signal 1');

x2 = exp(1i * 2 * pi * 5 * t1) + exp(1i * 2 * pi * 5.1 * t1);
y2 = fftshift(fft(x2));

subplot(2, 2, 2);
plot(f1, abs(y2));
xlabel('Frequency');
ylabel('F(x2)');
title('Signal 2');


fs = 50;
t2 = -1:1/fs:0.98;
x3 = cos(10 * pi * t2);

subplot(2, 2, 3);
plot(t2, x3);
title('$cos(10*\pi*t)$','interpreter','latex');


f3 = -25:0.5:24.5;
y3 = fftshift(fft(x3));


subplot(2, 2, 4);
plot(f3, abs(y3) / max(abs(y3)));
xlabel('Frequency');
ylabel('F(x3)');
title('Signal 3');
