
clc;
clear;
close all;

fs = 100;
t = 0:1/fs:0.99;
x = cos(30 * pi * t + (pi/4));

figure;
subplot(3, 1, 1);
plot(t, x);
title('$cos(30*\pi*t+(\pi/4))$','interpreter','latex');

f = -50:1:49;
y = fftshift(fft(x));

subplot(3, 1, 2);
plot(f, abs(y)/max(abs(y)));
xlabel('Frequency');
ylabel('F(x)');

tol = 1e-6;
y(abs(y) < tol) = 0;
theta = angle(y);

subplot(3, 1, 3);
plot(f, theta/pi);
xlabel('Frequency');
ylabel('Phase / \pi');
title('Phase of Signal');
