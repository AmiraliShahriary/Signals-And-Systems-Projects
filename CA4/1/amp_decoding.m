function DecodedText = amp_decoding(coding_amp , rate)
    CorrArr = [];
    
    for i = 1:100:length(coding_amp)
        x = 1 : 0.01 : (2-0.01);
        y = 2*sin(2*pi.*x);
        
        CorrArr = [CorrArr , 0.01*(coding_amp(i:(i+99))*y')];
    end
    tmp = dec2bin(uint8(CorrArr .* (2.^rate - 1)));
    
    tmp_str = '';
    
    [numRows,numCols] = size(tmp);
    for i = 1:numRows
        tmp_str = strcat (tmp_str, tmp(i,:));
    end
    

    Mapset = CreateMapset();
    
    DecodedText = '';
    for i = 1:5:strlength(tmp_str)
        index = find(strcmp(Mapset(2,:), tmp_str(i:i+4)));
        DecodedText = strjoin([DecodedText , Mapset(1,index)],'');
    end
    
    DecodedText
end