t=0:0.01:1;
z1=sin(2*pi*t);
z2=cos(2*pi*t);

figure;

subplot(1,2,1);
plot(t, z1, '--b');
title('sin');
xlabel('time');
ylabel('amplitude');
grid on;
legend('sin');

subplot(1,2,2);
plot(t, z2, 'r');
title('cos');
xlabel('time');
ylabel('amplitude');
grid on;
legend('cos');
