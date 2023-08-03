clc;
close all;
clear all;

%original = imread('tiger.jpeg');
original = imread('tiger_test.jpg');

%original = imread('tiger.jpeg');
%original
subplot(2,2,1), imshow(original);
title("original");
%only red
only_red = original;
only_red(:,:,2:3) = deal(0);
subplot(2,2,2), imshow(only_red);
title("only red");
%move red to green
move_red_to_green = original;
move_red_to_green(:,:,1:2:3) = deal(0);
move_red_to_green(:,:,2) = only_red(:,:,1);
subplot(2,2,3), imshow(move_red_to_green);
title("Move red to green");
%blur by array ops
blur = original;
blur(2:end-1,2:end-1,:) = (double(original(1:end-2,2:end-1,:))...
    +double(original(2:end-1,1:end-2,:))...
    +double(original(3:end,2:end-1,:))...
    +double(original(2:end-1,3:end,:)))./4;
subplot(2,2,4), imshow(blur);
title("Blur");

%blur more by array ops
for i = 1:1000
blur2 = original;
blur2(2:end-1,2:end-1,:) = ...
    (double(original(1:end-2,2:end-1,:))...%top middle
    +double(original(1:end-2,1:end-2,:))...%top left
    +double(original(2:end-1,1:end-2,:))...%middle left
    +double(original(3:end,1:end-2,:))...  %bottom left
    +double(original(3:end,2:end-1,:))...  %bottom middle
    +double(original(3:end,3:end,:))...    %bottom right
    +double(original(2:end-1,3:end,:))...  %middle right
    +double(original(1:end-2,3:end,:)))... %top right
    ./9;
end
figure;
imshow(blur2);
title("Blur more");
figure;
imshow(blur);

%blur by loop
%{
for i = 2:size(blur2,1)-1
    for j = 2:size(blur2,2)-1
        blur2(i,j,:) = (original(i-1,j,:)+original(i,j-1,:)+original(i+1,j,:)+original(i,j+1,:))./4;
    end
end
figure;
imshow(blur2);
%}

%gaussian blur by loop
gaussian_kernel = (1/256)*[1 4 6 4 1; 4 16 24 16 4; 6 24 36 24 6; 4 16 24 16 4; 1 4 6 4 1];
sharpening_kernel = [0 -.5 0; -.5 3 -.5; 0 -.5 0];
kernel = sharpening_kernel;
offset(1) = ceil((size(kernel,1))/2);
offset(2) = ceil((size(kernel,2))/2);
gaussian_image = original;
gaussian_image(:) = deal(0);

for i = offset(1):size(original,1)-offset(1)+1
    for j = offset(2):size(original,2)-offset(2)+1
        for k = 1:size(kernel,1)
            for m = 1:size(kernel,2)
                gaussian_image(i,j,1) = double(gaussian_image(i,j,1)) + double(original(i-k+offset(1),j-m+offset(2),1))*kernel(k,m);
                gaussian_image(i,j,2) = double(gaussian_image(i,j,2)) + double(original(i-k+offset(1),j-m+offset(2),2))*kernel(k,m);
                gaussian_image(i,j,3) = double(gaussian_image(i,j,3)) + double(original(i-k+offset(1),j-m+offset(2),3))*kernel(k,m);
            end
        end
    end
end
figure;
imshow(gaussian_image);
title("gaussian image");