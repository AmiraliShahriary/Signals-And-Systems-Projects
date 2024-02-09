[x, fs] = audioread('Sher.wav');
speed = 1.9;
p4(x, speed, fs);

function y = p4(x, speed, fs)
    if speed >= 0.5 && speed <= 2 && mod(speed, 0.1) == 0
        y = interp1(1:size(x, 1), x, linspace(1, size(x, 1), size(x, 1)*1/speed));
        sound(y, fs);
    else
        error('wrong input use something between 0.5 and 2 & multiple of 0.1.');
    end
end
