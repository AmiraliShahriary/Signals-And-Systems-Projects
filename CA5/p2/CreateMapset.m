function SignalMapping = generate_signal_mapping()
    SignalMapping = cell(2, 32);
    alphabet = char(97:122);
    
    for idx = 1:26
        SignalMapping(1, idx) = cellstr(alphabet(idx));
    end
    
    specialChars = {' ', '.', ',', '!', ':'};
    for idx = 1:length(specialChars)
        SignalMapping(1, 26 + idx) = cellstr(specialChars{idx});
    end

    for idx = 1:32
        SignalMapping(2, idx) = cellstr(dec2bin(idx-1, 5));
    end
end
