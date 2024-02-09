clear;clc;
filename="a.wav";
[a,Fs]=audioread(filename);
sound(a,Fs)
data=cell(2,12);
fr=[697 770 852 941];
fc=[1209 1336 1477];
fs=8000;
Ts=1/fs;
Ton=0.1;
t=0:Ts:Ton;
Toff=0.1;
on=Ton*fs;
s=size(a);
data_name=['1','2','3','4','5','6','7','8','9','*','0','#'];
output=[];
for n=1:12
    num=n;
    row=ceil(num/3);
    column=rem(num,3);
    if column==0
        column=3;
    end
    y1=sin(2*pi*fr(row)*t);
    y2=sin(2*pi*fc(column)*t);
    y=(y1+y2)/2;
    data(1,n)={data_name(n)};
    data(2,n)={y(1:on)};
end

for n=0:(s(1)/(0.2*Fs))-1
    samples=[(2*n*Fs*0.1)+1,(2*n*Fs*0.1)+on];
    [b,Fs]=audioread(filename,samples);
    ro=zeros(1,12);
    for i=1:12
        ro(i)=corr2(data{2,i},transpose(b));
    end
    [MAXRO,pos]=max(ro);
    na=cell2mat(data(1,pos)); 
    output=[output na];
end
output

