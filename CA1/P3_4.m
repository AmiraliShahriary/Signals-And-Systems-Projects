ts=0.000000001;
T=0.00001;
t=0:ts:T;
tlen=length(t);
x=zeros(1,tlen);
N=round(tlen/10);
x(1:N)=1;
t2=0:1:11;
t2len=length(t2);
y=zeros(1,tlen);
index=3001;
y(index:index+N-1)=0.5;
Ravg=zeros(1,t2len);

Rindex=450;
R=zeros(1,100);

for n=1:12
    for j=1:100
        noise=n*randn(1,tlen);
        z=y+noise;
        
        for i=1:tlen-N
            tempp=zeros(1,tlen);
            tempp(i:i+N-1)=1;
            ro(i)=sum(tempp .* z);
        end
        
        [val,pos]=max(ro);
        th=400;
        if val>th
            td=t(pos);
            C=3e8;
            R(j)=C*td/2;
            Ravg(n)=Ravg(n)+abs((R(j)-Rindex));
        end
    end
    Ravg(n)=Ravg(n)/100;
end

figure;
plot(t2,Ravg,'LineWidth',2)
legend('Ravg');
title('Ravg');
xlabel('noise power')
ylabel('amplitude')
grid on;
