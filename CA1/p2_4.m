% generate  data without noise
x = linspace(0, 1, 100)';
a_true = 2;
b_true = 1;
y_true = a_true * x + b_true;

% add noise
noise = 0.1 * randn(size(x));
y_noisy = y_true + noise;

% Estimate parameters
[a_est, b_est] = estimate_ab(x, y_noisy);


disp(['True a: ', num2str(a_true)]);
disp(['Estimated a: ', num2str(a_est)]);
disp(['True b: ', num2str(b_true)]);
disp(['Estimated b: ', num2str(b_est)]);


function [a, b] = estimate_ab(x, y)
    n = length(x);
    A = [x, ones(n, 1)];
    params = A \ y;
    a = params(1);
    b = params(2);
end
