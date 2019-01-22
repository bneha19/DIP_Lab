clc; clear; close all;

img = imread('lena.jpg');
subplot(2,2,1);
imshow(img);
title('Original Image');

gray = rgb2gray(img);
subplot(2,2,2);
imshow(gray);
title('Grayscale Image');

img_d = double(gray);
weight = zeros(3);

% padding the image
padding_row = zeros(1,size(img,1));
padding_colm = zeros(size(img,2)+2,1);
Rpadded_img = [padding_row;img_d;padding_row];
padded_image = [padding_colm,Rpadded_img,padding_colm];
subplot(2,2,3);
imshow(uint8(padded_image));
title('Padded Image');

result = zeros(size(padded_image));

% determining the weights of each pixel in image
for i = 2 : size(padded_image,1)-1
    for j = 2 : size(padded_image,2)-1
        if padded_image(i,j)>padded_image(i,j+1)
            weight(2,3)=1;
        else
            weight(2,3)=0;
        end

        if padded_image(i,j)>padded_image(i-1,j+1)
            weight(1,3)=2;
        else
            weight(1,3)=0;
        end

        if padded_image(i,j)>padded_image(i-1,j)
            weight(1,2)=4;
        else
            weight(1,2)=0;
        end

        if padded_image(i,j)>padded_image(i-1,j-1)
            weight(1,1)=8;
        else
            weight(1,1)=0;
        end

        if padded_image(i,j)>padded_image(i,j-1)
            weight(2,1)=16;
        else
            weight(2,1)=0;
        end

        if padded_image(i,j)>padded_image(i+1,j-1)
            weight(3,1)=32;
        else
            weight(3,1)=0;
        end

        if padded_image(i,j)>padded_image(i+1,j)
            weight(3,2)=64;
        else
            weight(3,2)=0;
        end

        if padded_image(i,j)>padded_image(i+1,j+1)
            weight(3,3)=128;
        else
            weight(3,3)=0;
        end

        % summing the weights of neighbour pixels and adding them
        new_value = sum(sum(weight));
        %replace the value in new imagegithu
        result(i,j) = new_value;
    end
end

subplot(2,2,4);
result = uint8(result);
imshow(result);
title('Local Binary Pattern') 