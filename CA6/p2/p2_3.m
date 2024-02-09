clear; clc;

[audio_data, sample_rate] = audioread('mysong1.wav');
start_time = 0;
fs = 8000;
time_step = 1/fs;
end_time = 0.5;
attack_duration = 0.025;

time_vector = start_time:time_step:end_time-time_step;
attack_vector = start_time:time_step:attack_duration-time_step;
silence_segment = zeros(size(attack_vector));

note_names = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"];
note_frequencies = [523.25,554.37,587.33,622.25,659.25,698.46,739.99,783.99,830.61,880,932.33,987.77];

notes_cell = {};
end_index = length(audio_data);
note_index = 1;

while end_index ~= 0
    for i = 2:end_index
        if audio_data(i) == 0 && audio_data(i+1) == 0
            break
        end
    end
    current_note = audio_data(1:i-1);
    notes_cell{note_index} = current_note;
    note_index = note_index + 1;
    audio_data = audio_data(i+200:end_index);
    end_index = length(audio_data);
    % sound(current_note);
end

final_result = cell(2, length(notes_cell));

for i = 1:length(notes_cell)
    current_note = cell2mat(notes_cell(i));
    note_length = length(current_note);
    magnitude = abs(fftshift(fft(current_note)));
    [row, col] = find(magnitude == max(magnitude));
    frequency_estimate = (row(2) - note_length/2 - 1) * fs / note_length;
    
    for j = 1:length(note_frequencies)
        threshold = 2;
        if abs(note_frequencies(j) - frequency_estimate) < threshold
            final_result{1, i} = note_names(j);
            final_result{2, i} = note_length / 4000;
        end
    end
end

final_result
