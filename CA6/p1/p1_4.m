clc
clear;
close all;


sigma=0.01;%power of noise (variance)

format short
t_start=0;t_end=1;
Fs=100;
fc=5;
N=Fs*t_end;

t=(0:N-1)/Fs;
V=180;
v=V/3.6;
R=250;
r=R*1000;
beta=0.3;
alpha=0.5;
C=3e8;
rho=2/C;
td=rho*r;
fd=beta*v;


% X received signal

w=randn(1,length(t));
xr=sigma*w+alpha*cos(2*pi*(fc+fd)*(t-td));


%plot x received
figure
plot(t,xr)
grid on
ylim([-2 2])
xlim([t_start t_end])
title 'Received Signal'
xlabel("time")
ylabel("Amplitude")


%fourier part
fshift = (-N/2:N/2-1)*(Fs/N);                 
X=fftshift(fft(xr));                           
Fx = X/max(abs(X));                          
f = Fs*(0:N-1)/N;                             

figure
plot(fshift,abs(Fx));
grid on
title('Spectrum of Fx(f)')
xlabel('f (Hz)')
ylabel('|Fx(f)|')
legend('Fourier  of Received Signal')


%Estimating fd ,td
In=find(abs(Fx)==max(abs(Fx)));
FD=fshift(In(2))-fc;                            
TD=angle(Fx(In(2)))/(-2*pi*(FD+fc));            
%Estimating distance (R) , velocity (V)
r_est=(TD/rho)/1000;                                   
v_est=FD*3.6/beta;                             
sprintf("distance (R found) = %.4f km \n velocity (V found)  = %.4f km/h", r_est , v_est)