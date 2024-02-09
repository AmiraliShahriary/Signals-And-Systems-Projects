%%
% Constants and Setup Commands
clc
clear;
close all;
format short
t_start=0;t_end=1;
Fs=100;
N=Fs*t_end;
fc=5;
Beta=0.3;
C=3e8;
rho=2/C;
t=(0:N-1)/Fs;

V1=216;v1=V1/3.6;
R1=200;
alpha1=0.5;
td1=rho*R1;
fd1=Beta*v1;

V2=180;v2=V2/3.6;
R2=200;
alpha2=0.6;
td2=rho*R2;
fd2=Beta*v2;

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

% Fourier part
fshift = (-N/2:N/2-1)*(Fs/N);                      
X=fftshift(fft(xr));                               
Fx = X/max(abs(X));                                 
f = Fs*(0:N-1)/N;                                   

% Plotting
figure
plot(fshift,abs(Fx));

title('Spectrum of Fx(f)')
xlabel('f (Hz)')
ylabel('|Fx(f)|')
legend('Fourier of Received Signal')

% Estimating fd ,td
[peaksvalus , locs]=findpeaks(abs(X(N/2:N)));
thereshold=0.75*max(abs(X));
indexes=peaksvalus>thereshold;
pot_freq=[locs(indexes)];
FD=f(pot_freq-1)-fc;
indexes=find(ismember(fshift,pot_freq-2));
TD=angle(Fx(indexes))./(-2*pi*(FD+fc));           

% Estimating distance (R) , velocity (V)
Est_R=TD/rho;                                       
Est_V=FD*3.6/Beta;                                 


str="";
for i=1:length(Est_V)
    str=str+sprintf("%d:\nEstimated distance = %.4f km \nEstimated velocity = %.4f km/h\n",i, Est_R(i) , Est_V(i));
end
disp(str)