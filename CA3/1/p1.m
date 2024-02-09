clc
clearvars;

number = 32;
dec2bin(0:31,5); 
mapset = cell(2, number);
alphabet = 'abcdefghijklmnopqrstuvwxyz .,!";';

for i = 1:number
    mapset{1,i} = alphabet(i);
    mapset{2,i} = dec2bin(i-1, 5);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%

image = imread("picture.png");
image = rgb2gray(image);

message='signal;';
message_len=length(message);
message_binary=cell(1,message_len);

for i = 1:message_len
    current_char=message(i);
    index=strcmp(current_char,mapset(1,:));
    message_binary(i) = mapset(2,index);
end


binarymessage_encoded=cell2mat(message_binary);
binarymessage_len=length(binarymessage_encoded);
encoded_image =image;

for i = 1:binarymessage_len
    vals=image(i);
    valsbin1=dec2bin(vals);
    valsbin1(end)=binarymessage_encoded(i);
    encoded_image (i)=bin2dec(valsbin1);
end
encrypted_filename = 'encrypted_image.png';
imwrite(encoded_image , encrypted_filename);

subplot(1,2,1);
imshow(image);
title("Original photo")
subplot(1,2,2);
imshow(encoded_image);
title("Encrypted photo")


