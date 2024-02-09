clc
clear all
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
text = 'signal';
rate = 1;
noise_variance =1.25;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Coded = coding_freq(text, rate);
plot (Coded(1,:) ,Coded(2,:));
Noise = noise_variance * randn(1, length(Coded(2,:)));
Coded(2,:) = Coded(2,:) + Noise;
output = decoding_freq(Coded, rate);
output

