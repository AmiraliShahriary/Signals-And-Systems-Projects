
generate_dtmf_tones('43218765');

function generate_dtmf_tones(my_number)

    fr=[697 770 852 941];
    fc=[1209 1336 1477];
    fs=8000;
    Ts=1/fs;
    Ton=0.1;
    Toff=0.1;
    t=0:Ts:Ton;
    silence=zeros(1,size(t,2)-1);
    out=[];
    
    n = 1;
    while n <= length(my_number)
        if my_number(n) == '*'
            row=4;
            column=1;
        elseif my_number(n) == '#'
            row=4;
            column=3;
        elseif my_number(n) == '0'
            row=4;
            column=2;
        else
            num=str2num(my_number(n));
            row=ceil(num/3);
            column=rem(num,3);
            if column==0
                column=3;
            end
        end
        y1=sin(2*pi*fr(row)*t);
        y2=sin(2*pi*fc(column)*t);
        y=(y1+y2)/2;
        on=Ton*fs;
        out=[out y(1:on) silence];
        n = n + 1;
    end

    sound(out,fs)
    audiowrite('y.wav',out,fs)

end
