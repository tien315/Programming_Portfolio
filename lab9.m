%Lab 9 - Animations and Neighbors
%Alan Tieng
%UIC, CS109, Spring 2020, Reckinger
 
clear all;
close all;
clc;
 
%%Part 1, write the code the produces the animation provided.  Use the
%%function:
%%x goes from 1 to 50 with a step size of 1
%%y should be the cos(x/pi) for each x value
%%You will not be able to test this on Zybooks, so just get it working and show your grad TA. 

pause('on');
x = 0:50;
for i = 1:51
    plot(x(1:i),cos(x(1:i)./pi))
    xlim([0 50])
    ylim([-1 1])
    pause(.05);
end

%%This code is used to test the function you will write below. Do not
%%change any of this code.  
 
map = [10 10 10 10 10 10 10 10; 10 40 40 40 40 40 40 10; 10 40 30 30 30 30 40 10; 10 40 30 20 20 30 40 10; 10 40 30 30 30 30 40 10; 10 40 40 40 40 40 40 10; 10 10 10 10 10 10 10 10];
figure
xat = 4;
yat = 5;
imagesc(map);  %plots array visually.  does not flip vertically (like contourf does).  helps visualize 2d data.
hold on
plot(xat, yat, 'h', 'MarkerSize', 25, 'Color', 'red', 'MarkerFaceColor', 'red');
 
[xs, ys] = findNeighbors(map, yat, xat, "south");
[xn, yn] = findNeighbors(map, yat, xat, "north");
[xw, yw] = findNeighbors(map, yat, xat, "west");
[xe, ye] = findNeighbors(map, yat, xat, "east");
grid on
plot(xs, ys, 'o', 'MarkerSize', 25, 'Color', 'black', 'Linewidth', 2);
plot(xn, yn, 'd', 'MarkerSize', 25, 'Color', 'blue', 'Linewidth', 2);
plot(xw, yw, 's', 'MarkerSize', 25, 'Color', 'magenta', 'Linewidth', 2);
plot(xe, ye, '*', 'MarkerSize', 25, 'Color', 'cyan', 'Linewidth', 2);
legend("Here", "South", "North", "West", "East");
set(gca, 'fontsize', 16);
title ("Neighbors");
colorbar
 
 
 
%%Part 2 - write the findNeighbors function. 
%%INPUTS
%%map - the 2D array "map" that you are exploring.
%%row - the row index of the location you are at.
%%col - the column index of the location you are at.
%%direction - either "south", "north", "east", or "west" - indicating which
%%neighbors you should return.
%%OUTPUTS
%%x - the column locations of the neighbors indicated by direction
%%y - the row locations of the neighbors indicated by direction
%%EXAMPLE
%%given direction = "east", then the two outputs are:
%%x = [col+1, col+1, col+1];
%%y = [row-1, row, row+1];
%%Therefore, I did one of the branches for you (east).  You can put this
%%directly in your code, as is.  You should do the other three.  
%%ERROR CHECKING
%%if row and col inputted do not have all 8 neighbors, the function should
%%always return empty arrays for both x and y.
function [x, y] = findNeighbors(map, row, col, direction)
%TODO_2 - Write this function.  Remove the x and y definitions below once
%you start working on this function.  To create the plot shown in Zybooks,
%you do not need to do anything other than work on this function.
if (size(map,1) == row) || (size(map, 2) == col) || (row == 1) || (col == 1)
    x = [];
    y = [];
    return
end

switch direction
    case "north"
        x = [col-1, col, col+1];
        y = [row-1, row-1, row-1];
    case "east"
        x = [col+1, col+1, col+1];
        y = [row-1, row, row+1];
    case "west"
        x = [col-1, col-1, col-1];
        y = [row-1, row, row+1];
    case "south"
        x = [col-1, col, col+1];
        y = [row+1, row+1, row+1];
    otherwise
        disp("Invalid direction")
end
 
end