ts = 1e-9; 
T = 1e-5;  
tau = 1e-6; 

t=0:ts:T;
tlen=length(t);
sent=zeros(1,tlen);
sent(1:round(tau/ts))=1;


plot(t,sent);
xlabel("power of noise");
ylabel("error of distance emstimation ");
ylim([-1,2]);
hold on;