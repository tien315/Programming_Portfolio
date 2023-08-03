%Lab 7 - Mystery Images
%Alan Tieng
%CS 109, Spring 2020, Reckinger

clc;
clear all;
close all;

%plot uncovered images to the right of their covered versions
for i=1:4
   [original, uncovered] = mysteryImages(i); 
   subplot(4,2,i*2-1);
   imshow(original);
   title("original");
   subplot(4,2,i*2);
   imshow(uncovered);
   title("uncovered");
end

%This function processes some mystery images to uncover the data that
%actually represents the image.  
%INPUTS:
%-opt = either 1, 2, 3, or 4.  Each number corresponds to one of the four
%mystery images.
%OUTPUTS:
%-original - the array of image data of the original image.
%-uncovered - the array of image data of the uncovered image.

function [original, uncovered] = mysteryImages(opt)
switch opt
    case 1
        %remove blue and green layers, multiply red layer by 10
        original = imread('mystery1.png');
        uncovered = original;
        uncovered(:,:,2:3) = deal(0);
        uncovered(:,:,1) = original(:,:,1)*10;
    case 2
        %remove red layer, multiply green and blue layers by 10
        original = imread('mystery2.png');
        uncovered = original;
        uncovered(:,:,1) = deal(0);
        uncovered(:,:,2:3) = original(:,:,2:3)*20;
    case 3
        %remove red and green layers, remove all val above 15 in blue layer
        %and multiply val < 16 by 16
        original = imread('mystery3.png');
        uncovered = original;
        uncovered(uncovered>15) = 0;
        uncovered = uncovered*16;
        uncovered(:,:,1) = uncovered(:,:,3);
        uncovered(:,:,2:3) = deal(0);
    case 4
        %remove red and blue layers, remove green layer elements in a
        %checkerboard pattern starting with (1,1) multiply val by 5, then
        %multiply next val by 20 and repeat.
        original = imread('mystery4.png');
        uncovered = original;
        uncovered(:,:,1:2:3) = deal(0);
        uncovered(1:2:end,1:2:end,:) = uncovered(1:2:end,1:2:end,:)*5;
        uncovered(2:2:end,2:2:end,:) = uncovered(2:2:end,2:2:end,:)*5;
        uncovered(1:2:end,2:2:end,:) = uncovered(1:2:end,2:2:end,:)*20;
        uncovered(2:2:end,1:2:end,:) = uncovered(2:2:end,1:2:end,:)*20;
    otherwise
        original = [];
        uncovered = [];
        disp("Invalid input.");
end
end