clc
clearvars;

number = 32;
mapset = cell(2, number);
alphabet = 'abcdefghijklmnopqrstuvwxyz .,!";';
for i = 1:number
    mapset{1,i} = alphabet(i);
    mapset{2,i} = dec2bin(i-1, 5); 
end

encrypted_filename = 'encrypted_image.png'; 
encrypted_photo = imread(encrypted_filename);


message_bin = '';
for i = 1:size(encrypted_photo,1)
    pixel = encrypted_photo(i);
    pixel_bin = dec2bin(pixel);
    message_bin = [message_bin pixel_bin(end)]; 
end

message_decoded = '';
while length(message_bin) > 4
    char_bin = message_bin(1:5);
    message_bin = message_bin(6:end);
    
    index = find(strcmp(char_bin, mapset(2,:)));
    char = mapset{1,index};
    
    if char == ';'
        break;
    end
    message_decoded = [message_decoded char];
end
 
disp(message_decoded)