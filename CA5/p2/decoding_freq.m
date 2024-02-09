function DecodedText = decoding_freq(CodedSignal, rate)
    FourArr = [];
    for startIndex = 0:100:(length(CodedSignal)-1)   
        segment = CodedSignal(2, startIndex + 1:(startIndex + 100));
        fourier = fftshift(fft(segment));
        
        [~, idx] = max(abs(fourier));
        idx = idx - 51;
        
        FourArr = [FourArr, -1 * idx];
    end

    section = 50 / (2^rate + 1);
    BinArr = dec2bin(uint8(FourArr / section - 1));      
    
    BinArr = BinArr';
    
    BinStr = '';
    
    for charIndex = 1:numel(BinArr)
        BinStr = strcat(BinStr, BinArr(charIndex));
    end

    Mapset = CreateMapset();
    
    DecodedText = '';
    
    for i = 1:5:strlength(BinStr)
        binSubstring = BinStr(i:i+4);
        index = find(strcmp(Mapset(2,:), binSubstring));
        DecodedText = strjoin([DecodedText, Mapset(1, index)], '');
    end
end
