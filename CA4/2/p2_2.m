ts = 1e-9;
T = 1e-5;
tau = 1e-6;

t = 0:ts:T;
tlen = length(t);
sent = zeros(1, tlen);
sent(1:round(tau/ts)) = 1;

R = 450;
a = 0.5;
c = 3e8;

td = 2 * R / c;

received = circshift(0.5 * sent, round(td/ts));
% Use convolution instead of correlation
convolution_result = conv(received, flip(sent));

convolution_t = -T:ts:T;
convolution_t = convolution_t(1:length(convolution_result));

figure;

plot(convolution_t, convolution_result);
xlabel('Time Delay (s)');
ylabel('Convolution');
title('Convolution Result');
hold on;

[max_conv, max_idx] = max(convolution_result);
plot(convolution_t(max_idx), max_conv, 'ro');
legend('Convolution Result', 'Peak');

time_delay = convolution_t(max_idx);
estimated_R = time_delay * c / 2;

disp(['Estimated Distance (R): ', num2str(estimated_R), ' meters']);
