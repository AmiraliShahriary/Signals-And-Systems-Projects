
% SELECTING THE TEST DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
picture=imread(s);
figure
subplot(1,2,1)
imshow(picture)
picture=imresize(picture,[300 500]);
subplot(1,2,2)
imshow(picture)

% RGB2GRAY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gray_picture = mygrayfun(picture);
figure
subplot(1,2,1)
imshow(picture)
title('Original Image')

subplot(1,2,2)
imshow(gray_picture)
title('Grayscale Image')

% THRESHOLDING and CONVERSION TO A BINARY IMAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
chosen_threshold = 100; 

binary_picture = ~mybinaryfun(gray_picture, chosen_threshold);


figure
subplot(1,2,1)
imshow(gray_picture)
title('Grayscale Image')

subplot(1,2,2)
imshow(binary_picture)
title('Binary Image')

% REMOVE SMALL COMPONENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = 350; 

cleaned_picture = myremovecom(binary_picture, n);

figure
subplot(1, 4, 1);
imshow(binary_picture);
title('Original Binary Image');

subplot(1, 4, 2);
imshow(cleaned_picture);
title('Cleaned Binary Image');

only_noisy_pic = myremovecom(binary_picture, 2350);
subplot(1,4,3)
imshow(only_noisy_pic)
title('only noisy part image');
picture2=cleaned_picture-only_noisy_pic;
subplot(1,4,4)
imshow(picture2)
title('final pic');
% Labeling connected components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


image = picture2 > 0;

[L, Ne] = mysegmentation(image);

figure
imshow(picture2);
title('Segment');

propied = regionprops(L, 'BoundingBox');
hold on

for n = 1:size(propied, 1)
    rectangle('Position', propied(n).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 2);
end

hold off



% Decision Making
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

stats = regionprops(L, 'Centroid');
centroids = cat(1, stats.Centroid);


[~, sorted_idx] = sort(centroids(:,1));

load TRAININGSET;
totalLetters = size(TRAIN, 2);

figure
final_output = [];
t = [];
for i = 1:numel(sorted_idx)
    n = sorted_idx(i);
    [r,c] = find(L == n);
    Y = picture2(min(r):max(r),min(c):max(c));
    imshow(Y)
    Y = imresize(Y,[42,24]);
    imshow(Y)
    pause(0.2)
    
    ro = zeros(1,totalLetters);
    for k = 1:totalLetters   
        ro(k) = corr2(TRAIN{1,k},Y);
    end

    [MAXRO, pos] = max(ro);
    if MAXRO > 0.45
        out = cell2mat(TRAIN(2, pos));       
        final_output = [final_output out];
    end
end

% Printing the plate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
file = fopen('number_Plate.txt', 'wt');
fprintf(file, '%s\n', final_output);
fclose(file);
winopen('number_Plate.txt')
toc


function gray_image = mygrayfun(color_image)

    red_channel = color_image(:,:,1);
    green_channel = color_image(:,:,2);
    blue_channel = color_image(:,:,3);
    
    gray_image = 0.299 * red_channel + 0.578 * green_channel + 0.114 * blue_channel;
    

    gray_image = uint8(gray_image);
end

function binary_image = mybinaryfun(grayscale_image, threshold)
    binary_image = grayscale_image > threshold;
end

function [cleaned_image, only_noisy_pic] = myremovecom(binary_image, n)
    [L, num] = bwlabel(binary_image);
    
    stats = regionprops(L, 'Area');

    small_components = find([stats.Area] < n);

    for i = 1:length(small_components)
        binary_image(L == small_components(i)) = 0;
    end

    cleaned_image = binary_image;
end



function [L, Ne] = mysegmentation(image)
    [rows, cols] = size(image);
    L = zeros(rows, cols);
    Ne = 0;

    neighbors = [0 1; 1 0; 0 -1; -1 0];

    for i = 1:rows
        for j = 1:cols
            if image(i, j) == 1 && L(i, j) == 0
                Ne = Ne + 1;
                stack = [i, j];
                top = 1;

                while top > 0
                    x = stack(top, 1);
                    y = stack(top, 2);
                    top = top - 1;

                    L(x, y) = Ne;

                    for k = 1:size(neighbors, 1)
                        x_n = x + neighbors(k, 1);
                        y_n = y + neighbors(k, 2);

                        if x_n >= 1 && x_n <= rows && y_n >= 1 && y_n <= cols && image(x_n, y_n) == 1 && L(x_n, y_n) == 0
                            top = top + 1;
                            stack(top, :) = [x_n, y_n];
                        end
                    end
                end
            end
        end
    end
end



