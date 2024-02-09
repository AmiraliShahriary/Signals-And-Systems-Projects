function CodedSignal = coding_freq(ClearText, rate)

Mapset = CreateMapset();

BinStr = '';
for charIndex = 1:strlength(ClearText)
    charMappingIndex = find(strcmp(Mapset(1,:), ClearText(charIndex)));
    BinStr = strjoin([BinStr, Mapset(2, charMappingIndex)], '');
end

CodedSignal = zeros(2, strlength(BinStr) * 100 / rate);

section = 50 / (2^rate + 1);

i = 0;

while i + rate <= strlength(BinStr)
    temp = BinStr((i + 1):(i + rate));
    factor = (bin2dec(temp) + 1) * section;
    
    time_range = (i / rate) : 0.01 : ((i / rate) + 1 - 0.01);
    signal = sin(2 * pi * factor * time_range);
    
    sample_range = ((i / rate) * 100 + 1):((i / rate) * 100 + 100);
    CodedSignal(1, sample_range) = time_range;
    CodedSignal(2, sample_range) = signal;
    
    i = i + rate;
end
end