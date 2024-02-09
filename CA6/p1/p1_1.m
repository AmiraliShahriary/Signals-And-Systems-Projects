clc
clear
close all

Fs=100;
fc=5;
t_end=1;
t=0:1/Fs:t_end-1/Fs; % creating time vector
x=cos(2*pi*fc*t);
V=50; %km/h is converted to m/s
R=250*1e3; % distance
alpha=0.5;
beta=0.3; 
c=3e8;
fd=beta*V; % doppler frequency
td=2/c*R;  % delay
tol=1e-5;  %tolerance
plot(t,x)
title('Transmitted Signal')
grid on
xlabel('Time (s)')
y=alpha*cos(2*pi*(fc+fd)*(t-td));
figure
plot(t,y)
title('Received Signal')
grid on
xlabel('Time (s)')



