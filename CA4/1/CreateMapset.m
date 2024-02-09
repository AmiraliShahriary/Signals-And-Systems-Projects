function Mapset = CreateMapset()
 Mapset = cell(2,32);


    alpha = char(97:122);
    for i = 1:26
        Mapset(1,i) = cellstr(alpha(i));
    end
    Mapset(1,27)=cellstr({' '});
    Mapset(1,28)=cellstr('.');
    Mapset(1,29)=cellstr(',');
    Mapset(1,30)=cellstr('!');
    Mapset(1,31)=cellstr(':');
    Mapset(1,32)=cellstr('"');

 
    for i = 1:32
        Mapset(2,i) = cellstr(dec2bin(i-1 , 5));
    end
end