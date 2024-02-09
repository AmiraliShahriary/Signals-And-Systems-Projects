
load('p2.mat');
t = 0:0.001:1;

figure;
plot(t, x);
title('Input Signal x(t)');
xlabel('Time (t)');
ylabel('x(t)');
grid on;
