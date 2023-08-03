%Project 9 - Animation of Life
%Alan Tieng
%CS 109, Spring 2020, Reckinger

%This function project9 will test the functions runLife and find_neighbors
%by animating six test cases.
function project9
clear all;
clc;
load('startingGrids.mat');

%test code

 gridOut = runLife(gridStill, 10);
 gridOut = runLife(gridBlinkers, 25); 
 gridOut = runLife(gridToadBeacon, 21);
 gridOut = runLife(gridRandom, 50);
 gridOut = runLife(gridSpaceShip, 50);
 gridOut = runLife(gridRandomBig, 150);
%}

end

%This function runLife will animate the game of life.  See life rules
%below.
%INPUTS
%grid - a 2d array of 1s and 0s.  Cells with a value of 1 are "live" and
%cells with a value of 0 are "dead".
%timeToStop - the number of iterations the life simulation should run
%OUTPUT
%grid - the input array grid after timeTopStop iterations.
%Life rules:
% Any live cell with fewer than two live neighbors dies [under-population]
% Any live cell with two or three live neighbors lives on to the next generation
% Any live cell with more than three live neighbors dies [over-population]
% Any dead cell with exactly three live neighbors becomes a live cell [reproduction]
function [grid] = runLife(grid, timeToStop)

pause('on');
%initialize gridwrap array
%       97897    97897
% 123 + 3***1 -> 31231
% 456 + 6***4 -> 64564
% 789 + 9***7 -> 97897
%       31231    31231
temp_grid = zeros(size(grid, 1)+2,size(grid, 2)+2);
for i = 1:timeToStop
    
    %insert edgewrap values with original grid interior
    temp_grid(1, 1:size(grid,2)+2) = [grid(end, end) grid(end, :) grid(end, 1)];%top
    temp_grid(2:end-1, :) = [grid(:, end), grid, grid(:, 1)];%middle
    temp_grid(end, 1:size(grid,2)+2) = [grid(1, end) grid(1, :) grid(1, 1)];%bottom
    
    %iterate only through interior (original grid values in temp_grid) and update original grid
    for j = 2:size(grid, 1)+1
        for k = 2:size(grid, 2)+1
            num_neighbors = find_neighbors(j, k, temp_grid);
            
            %update live cells
            if (grid(j-1, k-1) && ((num_neighbors > 3) || (num_neighbors < 2)))...%live cells
                    || ((num_neighbors == 3) && ~grid(j-1, k-1) ) %dead cells
                grid(j-1, k-1)  = ~grid(j-1, k-1);
            end
            
        end
    end
    
    %display array with .25 second refresh between iterations
    imagesc(grid);
    pause(0.25);
    
end

end

%This function find_neighbors will count the number of live cells within
%one space of the selected position within temp_grid, not including the
%cell at (j,k).
%INPUTS
%j - row position within temp_grid
%j - column position within temp_grid
%temp_grid - expanded grid that includes edgewrap values of the original
%grid
%OUTPUT
%num_neighbors - the number of live cells within one space of the selected
%position within temp_grid, not including the cell at (j,k).
function num_neighbors = find_neighbors(j, k, temp_grid)

%sum of live cells in a 3x3 grid centered at (j,k)
num_neighbors = sum(sum(temp_grid(j-1:j+1, k-1:k+1)));

%remove live cell at (j,k) from count if applicable
if temp_grid(j, k) == 1
    num_neighbors = num_neighbors - 1; 
end

end
