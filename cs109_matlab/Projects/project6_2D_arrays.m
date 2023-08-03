%Project 6 - 2D Arrays
%Alan Tieng
%CS 109, Spring 2020, Reckinger

clear all;
close all;
clc;

function [gridOut] = filterAndPlot(opt, gridIn)
gridOut = [];  %you will need to update this, this is here so code runs without error
if size(gridIn,1) ~= size(gridIn,2)
    disp("Grid is not an n x n matrix.");
    return;
end
switch opt
    case 1
        %--opt 1 - First, find the maximum value in the gridIn array.  Then, all
        %elements in gridIn, that are either 2 or 4, should be set to the maximum
        %value found.  Assign this new updated gridIn to the output, gridOut.
        grid_max = max(gridIn(:));
        gridIn(gridIn == 2 | gridIn == 4) = grid_max;
        gridOut = gridIn;
        plot_title = "filtered, opt=1";
    case 2
        %--opt 2 - First, find the minimum value in the gridIn array.  Then, set
        %all values in all odd rows equal to the minimum value found.  Assign this 
        %new updated gridIn to the output, gridOut.
        grid_min = min(gridIn(:));
        gridIn(1:2:end,:) = grid_min;
        gridOut = gridIn;
        plot_title = "filtered, opt=2";
    case 3
        %--opt 3 - First, find the minimum value in the gridIn array. Then, set the
        %diagonal and off diagonal values of the array equal the minmum value
        %found. Assign this new updated gridIn to the output, gridOut.
        grid_min = min(gridIn(:)); 
        for i = 1:size(gridIn,1)
            gridIn(i,i) = grid_min; %from top left to bottom right
            gridIn(end+1-i,i) = grid_min; %from bottom left to top right
        end
        gridOut = gridIn;
        plot_title = "filtered, opt=3";
    case 4
        %--opt 4 - First, find the minimum value in the gridIn array.  Then, set
        %all elements in all four boundaries of the grid to the minimum value.  
        %Assign this new updated gridIn to the output, gridOut.
        grid_min = min(gridIn(:));
        gridIn(1,:) = grid_min; %top row
        gridIn(end,:) = grid_min; %bottom row
        gridIn(:,1) = grid_min; %first column
        gridIn(:,end) = grid_min; %last column
        gridOut = gridIn;
        plot_title = "filtered, opt=4";
    case 5
        %--opt 5 - First, find the maximum value in the gridIn array.  Then, find
        %the middle row and middle column of gridIn and set all values in the
        %middle row and middle column to the maximum value found.  If there is an
        %odd number of rows/columns, there will be one middle.  If there is an even
        %number of rows/columns, there will be two middles.  Assign this new updated 
        %gridIn to the output, gridOut.  Functions that might be useful include:
        %floor, ceil, rem, etc.
        grid_max = max(gridIn(:));
        if rem(size(gridIn,1),2) == 0 %if n is even in an n x n array
            gridIn(size(gridIn,1)/2:(size(gridIn,1)/2+1),:) = grid_max;
            gridIn(:,size(gridIn,1)/2:(size(gridIn,1)/2+1)) = grid_max;
        else %if n is odd in an n x n array
            gridIn((size(gridIn,1)+1)/2,:) = grid_max;
            gridIn(:,(size(gridIn,1)+1)/2) = grid_max;
        end
        gridOut = gridIn;
        plot_title = "filtered, opt=5";
    case -1
        %--opt -1 - assign gridOut to gridIn unchanged.
        gridOut = gridIn;
        plot_title = "Original";
    otherwise
        disp("Invalid Option.")
        gridOut = [];
        return;
end

%In addition to outputting grid, this function should also plot it using
%the imagesc function.  See project description for sample plots (the plots
%use the colormap hot, and set axis to equal and tight). The plot should
%also have the proper title. 
imagesc(gridOut);
title(plot_title);
colormap(hot);
colorbar;
axis equal;
axis tight;
yticks(1:size(gridIn,1));
xticks(1:size(gridIn,2));

end