clc
clear all

text = 'signal';
rate = 1;% speed
noise_variance = 0; %variance

Coded = amp_coding(text, rate);

timelim = length(Coded);
t = 0 : 0.01 : (timelim/100 -0.01);
plot (t ,Coded);

Noise = noise_variance * randn(1, length(Coded));
Coded = Coded + Noise;
figure();
plot (t ,Coded);

amp_decoding(Coded, rate);