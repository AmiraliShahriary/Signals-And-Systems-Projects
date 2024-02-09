clear;clc;

start_time = 0;
sampling_rate = 8000;
time_step = 1/sampling_rate;
end_time = 0.5;
attack_time = 0.025;

time_vector = start_time:time_step:end_time-time_step;
attack_vector = start_time:time_step:attack_time-time_step;
silence_segment = zeros(size(attack_vector));

note_names = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"];
note_frequencies = [523.25,554.37,587.33,622.25,659.25,698.46,739.99,783.99,830.61,880,932.33,987.77];

my_music_score = {'D','D','G','F#','D','D','E','E','D','F#','D','E','D','E','F#','E','D','E','E','D','F#','D','E','D','E','D','F#','E','D','E','D','F#','E','D','D','E','F#','E','F#','F#','E','F#','F#','D'
    ;0.5,0.5,1,1,1,0.5,0.5,0.5,0.5,0.5,0.5,1,1,1,1,1,0.5,0.5,0.5,0.5,0.5,0.5,1,1,0.5,0.5,1,1,1,0.5,0.5,1,1,0.5,0.5,1,0.5,0.5,1,0.5,0.5,1,1,1};

melody = zeros(1, length(time_vector) * sum(cell2mat(my_music_score(2,:))));
index = 1;

for i = 1:length(my_music_score)
    note_name = my_music_score{1, i};
    duration = my_music_score{2, i};
    
    [~, note_index] = find(note_names == note_name);
    note_wave = sin(2*pi*note_frequencies(note_index)*time_vector);
    
    note_duration = round(duration * length(time_vector));
    
    melody(index:index+note_duration-1) = note_wave(1:note_duration);
    index = index + note_duration;
    

end

sound(melody);
audiowrite('my_melody.wav', melody, sampling_rate);
