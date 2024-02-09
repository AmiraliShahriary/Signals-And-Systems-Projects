
[x, fs] = audioread('Sher.wav');

duration = length(x) / fs;

t = linspace(0, duration, length(x));
figure;
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Audio Signal');

sound(x, fs);
audiowrite('x.wav', x, fs);
