clc;
clear;
close all;

PCB_image = select_image();
IC_image = select_image();

PCB_image_gray = rgb_to_gray(PCB_image);
IC_image_gray = rgb_to_gray(IC_image);
IC_image_gray_rotated = imrotate(IC_image_gray,180);

M = corr_matrix(PCB_image_gray, IC_image_gray);
M_rotated = corr_matrix(PCB_image_gray, IC_image_gray_rotated);
M_cell = {M, M_rotated};

result = plot_box(PCB_image, IC_image_gray, M_cell);

figure();

subplot(1,3,1);
imshow(PCB_image);
title("PCB Image");

subplot(1,3,2);
imshow(IC_image);
title("IC Image");

subplot(1,3,3);
imshow(result);
title('Matching Result');

figure();
subplot(1,2,1);
imshow(IC_image);
title("IC Image");

function picture = select_image()
    [file, path] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'}, 'choose');
    s = fullfile(path, file);
    picture = imread(s);
end

function grayscale = rgb_to_gray(picture)
    grayscale = 0.299 * picture(:,:,1) + 0.578 * picture(:,:,2) + 0.114 * picture(:,:,3);
end

function correlation_coef = corr_2d(picture1, picture2)
    a = sum(picture1(:) .* picture2(:));
    b = sqrt(sum(picture1(:).^2) .* sum(picture2(:).^2));
    correlation_coef = a / b;
end

function M = corr_matrix(PCB, IC)
    [PCB_row, PCB_col] = size(PCB);
    [IC_row, IC_col] = size(IC);
    IC = double(IC);
    M = zeros(PCB_row - IC_row + 1, PCB_col - IC_col + 1);
    for i = 1:(PCB_row - IC_row + 1)
        for j = 1:(PCB_col - IC_col + 1)
            PCB_cropped = double(PCB(i:i + IC_row - 1, j:j + IC_col - 1));
            M(i,j) = corr_2d(IC, PCB_cropped);
        end
    end
end

function result = plot_box(PCB, IC, M_cell)
    [IC_row, IC_col] = size(IC);
    threshold = 0.95;
    figure, imshow(PCB);
    hold on 
    for l = 1:length(M_cell)
        M_1 = cell2mat(M_cell(1,l));
        [rows, columns] = find(M_1 > threshold);
        for k = 1:length(rows)
            rectangle('Position', [columns(k), rows(k), IC_col, IC_row], 'EdgeColor', 'r', 'LineWidth', 2);
        end
    end
    F = getframe(gcf);
    result = frame2im(F);
end
