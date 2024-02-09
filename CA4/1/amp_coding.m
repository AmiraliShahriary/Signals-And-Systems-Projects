function coding_amp = amp_coding(ClearText, rate) 
Mapset = CreateMapset();

    BinStr = '';
    for i = 1:strlength(ClearText)
        index = find(strcmp(Mapset(1,:), ClearText(i)));
        BinStr = strjoin([BinStr , Mapset(2,index)],'');
    end

    coding_amp=[];
    i=0;
    while i < strlength(BinStr)
        i = i+rate;
        temp = BinStr((i-rate+1):i);
        factor = (bin2dec(temp))./(2.^rate - 1);
        
        x = (i-1) : 0.01 : (i-0.01);
        y = factor.*sin(2*pi.*x);
        coding_amp = [coding_amp , y];
    end
end