 calling_customer(1,1)
function calling_customer(number, counter)

    mapset = 'MAPSET';
    tmp = dir(mapset);
    name_dir = {tmp.name};
    voice_names = name_dir(3:end);
    dictionary = containers.Map;

    for i = 1:length(voice_names)
        [audioData, sampleRate] = audioread(fullfile(mapset, voice_names{i}));
        dictionary(voice_names{i}(1:end-4)) = audioData;
    end

    %%error handeling
    if (counter < 1) || (counter > 9)
        disp("baje number must be between 1 to 9");
        return;
    elseif (number < 1) || (number > 99)
        disp("customer number must be between 1 to 99");
        return;
    end
    numberText = getNumberText(number, dictionary);

    concatenatedAudio = [
        dictionary('shomareh'); 
        numberText;
        dictionary('baje');
        dictionary(int2str(counter))
    ];

    sound(concatenatedAudio, sampleRate);
end

function [numberText] = getNumberText(number, dictionary)
    if (number < 21) || (mod(number, 10) == 0)
        numberText = dictionary(int2str(number));
    else
        tensText = dictionary(int2str(number - mod(number, 10)));  
        onesText = dictionary(int2str(mod(number, 10)));
        numberText = [tensText; dictionary('o'); onesText];
    end
end
