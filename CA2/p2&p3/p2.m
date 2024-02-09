
clc
close all;
clear;
load TRAININGSET;
totalLetters=size(TRAIN,2);

% SELECTING THE TEST DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'choose');
s=[path,file];
picture=imread(s);

picture=imresize(picture,[300 500]);

%RGB2GRAY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
picture=rgb2gray(picture);

% THRESHOLDIG and CONVERSION TO A BINARY IMAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
threshold = graythresh(picture);
picture =~im2bw(picture,threshold);

% Removing the small objects and background
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

picture = bwareaopen(picture,500); 

background=bwareaopen(picture,8000);

picture2=picture-background;

% Labeling connected components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
imshow(picture2)
[L,Ne]=bwlabel(picture2);

propied=regionprops(L,'BoundingBox');
hold on

a = [];
for n = 1:Ne
    if (propied(n).BoundingBox(3) < 100 && propied(n).BoundingBox(3) > 15 && propied(n).BoundingBox(4) > 50)
        a = [a n];
    end
end



for i=1:length(a)
    n=a(i);
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off


% Decision Making
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
final_output="";
final_output2=[];
j=0;
for n=1:length(a)
    i=a(n);
    [r,c] = find(L==i);
    Y=picture2(min(r):max(r),min(c):max(c));
    Y=imresize(Y,[60,50]);
    pause(0.2)
    
    ro=zeros(1,totalLetters);
    for k=1:totalLetters   
        ro(k)=corr2(TRAIN{1,k},Y);
    end
    [MAXRO,pos]=max(ro);
    if MAXRO>.45
        j = j + 1;
        out=cell2mat(TRAIN(2,pos)); 
        final_output2=[final_output2 out];
        final_output(j)= out;
    end
end
final_output=flip(final_output)
file = fopen('number_Plate.txt', 'wt');

for i = 1:length(final_output2)
    fprintf(file, '%s\n', final_output2(i));
end

fclose(file);


winopen('number_Plate.txt')
