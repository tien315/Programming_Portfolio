%Project 7 - Sepia Filter and Green Screen
%Alan Tieng
%CS 109, Spring 2020, Reckinger
clc;
%test code goes here-------------------------------------------------------

%test sepia filter
figure;
image_names = ["bigben.jpg","catred.jpg","city.jpg",...
    "colorBackground.jpeg","dino.jpg","dog.jpg","dog2.jpg","lion.jpg",...
    "puppy.jpg","purpleBackground.jpg","space.jpeg",...
    "treeBackground.jpg","tiger.jpg"];
for i = 1:13
    subplot(5,3,i),imshow(sepiaFilter(char(image_names(i))));
end

%test green screen
%display images in a comparison grid, blank spaces mean size mismatch.
figure;
front_screen = [1 3 3 1 2 2 2];
CD = [2.5 1.3 1 1 1 1 1.5];
front = ["catred.jpg","dino.jpg","dog.jpg","dog2.jpg","lion.jpg",...
    "puppy.jpg","tiger.jpg"];
back = ["bigben.jpg","city.jpg","colorBackground.jpeg",...
    "purpleBackground.jpg","space.jpeg","treeBackground.jpg"];

%subplot position is opposite of array indexing
%create vector taking into account extra row and column needed for original
%images.
subplot_index = 1:(length(front)+1)*(length(back)+1);
%reshape and transpose so numbers match subplot positionS
subplot_index = reshape(subplot_index,[length(back)+1,length(front)+1])';
%take subplot positions for original images, subplot position 1 is empty
subplot_y_axis = subplot_index(2:end,1);
subplot_x_axis = subplot_index(1,2:end);
%remove positions occupied by original images
subplot_index(1,:) = [];
subplot_index(:,1) = [];
%transpose from subplot position to array indexing
subplot_index = subplot_index';
%convert to vector for easy looping
subplot_index = subplot_index(:);

%insert original images in first row and column skipping subplot position 1
for i = 1:length(subplot_x_axis)
    subplot(length(front)+1,length(back)+1,subplot_x_axis(i))
    imshow(char(back(i)));
end
for i = 1:length(subplot_y_axis)
    subplot(length(front)+1,length(back)+1,subplot_y_axis(i))
    imshow(char(front(i)));
end

%insert images left to right, top to bottom
for i = 1:length(front)
    for j = 1:length(back)
        subplot(length(front)+1,length(back)+1,subplot_index(length(back)*(i-1)+j));
        im = greenScreen(char(front(i)),char(back(j)),front_screen(i),CD(i));
        imshow(im)
    end
end
%end of test code----------------------------------------------------------

%This function applies a sepia filter to a photo
%INPUT - imageFile is a character array filename of an image.
%OUTPUT - imArraySepia - is an 3d image array with the sepia filter
%applied.
function [imArraySepia] = sepiaFilter(imageFile)
%red' = 0.393 * red + 0.769 * green + 0.189 * blue
%green' = 0.349 * red + 0.686 * green + 0.168 * blue
%blue' = 0.272 * red + 0.534 * green + 0.131 * blue
old_image = imread(imageFile);
imArraySepia(:,:,1) = old_image(:,:,1).*.393 ...
    + old_image(:,:,2) * .769 + old_image(:,:,3) * .189;
imArraySepia(:,:,2) = old_image(:,:,1).*.349 ...
    + old_image(:,:,2) * .686 + old_image(:,:,3) * .168;
imArraySepia(:,:,3) = old_image(:,:,1).*.272 ...
    + old_image(:,:,2) * .534 + old_image(:,:,3) * .131;
end

%This function overlays one image over another using a filtering algorithm 
%with a green screen,
%INPUTS
%frontFile - string filename of the front image (with a red, green, or blue
%screen).
%backFile - string filename of the background image.
%ch - 1 (red screen), 2 (green screen), 3 (blue screen)
%cd - channel difference (described above)
%OUTPUTS
%newImage - data array for the combined image.
%a plot of the new image your code should have:
%imshow(newImage) at the bottom so that it plots new the image.
function [newImage, logical_xfer] = greenScreen(frontFile, backFile, ch, cd)
%TODO: write the function here.

front_array = imread(frontFile);
back_array = imread(backFile);
newImage = front_array;
%image size match check across all dimensions.
for i = 1:length(size(front_array))
    if size(front_array,i) ~= size(back_array,i)
        newImage = [];
        return;
    end
end
%{
channel_comp = [1:size(front_array,3)];
channel_comp(ch) = [];
%iterate by row, then column
for i = 1:size(front_array,1)
    for j = 1:size(front_array,2)
        %check that selected channel is cd greater than all other channels,
        %back_array if true, else leave front_array data.
        if (size(front_array,3)-1) == sum(front_array(i,j,ch) ...
                > front_array(i,j,channel_comp)*cd)
            newImage(i,j,:) = back_array(i,j,:);
        end
    end
end
%}

%for test only, not for submission-----------------------------------------
%improve run time
channel_comp = [1:3];
channel_comp(ch) = [];
for i = 1:3
    logical_xfer(:,:,i) = (front_array(:,:,ch) > front_array(:,:,channel_comp(1))*cd)...
        & (front_array(:,:,ch) > front_array(:,:,channel_comp(2))*cd);
end
newImage(logical_xfer) = back_array(logical_xfer);
%--------------------------------------------------------------------------
end