ts = 1e-9; 
T = 1e-5;  
tau = 1e-6; 

t=0:ts:T;
tlen=length(t);
sent=zeros(1,tlen);
sent(1:round(tau/ts))=1;

R = 450; 
a = 0.5;
c = 3e8; 

td = 2 * R / c;

received = circshift(sent, round(td/ts));

figure;
plot(t, received);
xlabel('Time (s)');
ylabel('Received Signal');
title('Received Signal vs. Time');
