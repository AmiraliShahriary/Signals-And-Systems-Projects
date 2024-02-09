clear;clc;

tstart = 0;
fs = 8000;
ts = 1/fs;
tend = 0.5;
tau = 0.025;
t = tstart:ts:tend-ts;
t2 = tstart:ts:tau-ts;
silence = zeros(size(t2));

data_name = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"];
data_frequency = [523.25,554.37,587.33,622.25,659.25,698.46,739.99,783.99,830.61,880,932.33,987.77];


my_song={'D','D','E','D','G','F#','D','D','E','D','A','G','D','D','B','G','F#','E','C','C','B','G','A','G'
    ;0.5,0.5,1,1,1,1,0.5,0.5,1,1,1,1,0.5,0.5,1,1,1,1,0.5,0.5,1,1,1,1};
%my_song = {'F','F','F','F','E','F','F','E','F','G','A','G','F','F','F','F','E','F','F','C'
 %   ;0.5,0.25,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,1,0.5,0.5,0.25,0.5,0.5,0.5,0.5,0.5,1};

song = zeros(1, length(t) * sum(cell2mat(my_song(2,:))));
index = 1;

for i = 1:length(my_song)
    note_name = my_song{1, i};
    duration = my_song{2, i};
    
    [~, num] = find(data_name == note_name);
    y = sin(2*pi*data_frequency(num)*t);
    
    % Calculate note duration without rounding
    note_duration = duration * length(t);
    
    % Ensure that the song array has enough space for the note
    if index + note_duration - 1 > length(song)
        song = [song, zeros(1, note_duration)];
    end

    % Add the note to the song
    song(index:index+note_duration-1) = y(1:note_duration);
    index = index + note_duration;
   
end

sound(song, fs);
audiowrite('mysong.wav', song, fs);

