clc
clear;
close all;


format short

t_start=0;t_end=1;
Fs=100;
N=Fs*t_end;
fc=5;
t=(0:N-1)/Fs;
V1=180;
v1=V1/3.6;
V2=216;
v2=V2/3.6;
R1=250;
R2=200;
r1=R1*1000;
r2=R2*1000;
alpha1=0.5;
alpha2=0.6;
beta=0.3;
C=3e8;
rho=2/C;
td1=rho*r1;
fd1=beta*v1;
td2=rho*r2;
fd2=beta*v2;

% X received signal

xr=alpha1*cos(2*pi*(fc+fd1)*(t-td1))+alpha2*cos(2*pi*(fc+fd2)*(t-td2));

%plot x received

figure
plot(t,xr)
grid on
ylim([-2 2])
xlim([t_start t_end])
title 'Received Signal'
xlabel("time")
ylabel("Amplitude")
