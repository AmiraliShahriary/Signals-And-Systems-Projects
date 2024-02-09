

[x,fs]= audioread('Sher.wav');
speed = 2; 
p4(x, speed,fs);


function y = p4(x, speed,fs)
    if speed == 2
        y = x(1:2:end-1, :); 
    elseif speed == 0.5
        y = zeros(2*length(x)-1, size(x, 2)); 
        y(1:2:end, :) = x; 
        y(2:2:end-1, :) = (x(1:end-1, :) + x(2:end, :)) / 2;
    else
        error('Invalid speed. Please use 0.5 or 2.');
    end
    sound(y, fs); 
end

