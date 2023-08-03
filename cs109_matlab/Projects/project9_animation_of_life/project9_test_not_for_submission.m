clear all;
clc;
load startingGrids;

gridOut = runLife(gridRandom, 50);

%This function runLife will animate the game of life.  See life rules
%below.
%INPUTS
%grid - a 2d array of 1s and 0s.  Cells with a value of 1 are "live" and
%cells with a value of 0 are "dead".
%timeTopStop - the number of iterations the life simulation should run
%OUTPUT
%grid - the input array grid after timeTopStop iterations.
%Life rules:
% Any live cell with fewer than two live neighbors dies [under-population]
% Any live cell with two or three live neighbors lives on to the next generation
% Any live cell with more than three live neighbors dies [over-population]
% Any dead cell with exactly three live neighbors becomes a live cell [reproduction]
function [grid] = runLife(grid, timeToStop)
%initialize gridwrap array
temp_grid = zeros(size(grid,1)+2,size(grid,2)+2);
for i = 1:timeToStop
    
    %insert edgewrap values with original grid interior
    temp_grid(1,1:size(grid,2)+2) = [grid(end,end) grid(end, :) grid(end, 1)];%top
    temp_grid(2:end-1,:) = [grid(:,end), grid, grid(:, 1)];%middle
    temp_grid(end,1:size(grid,2)+2) = [grid(1,end) grid(1, :) grid(1, 1)];%bottom
    
    %{
    temp_grid = [grid grid grid; grid grid grid; grid grid grid];
    temp_grid(1:size(grid,1)-1,:) = [];
    temp_grid(size(grid,1)*2+2:end,:) = [];
    temp_grid(:,1:size(grid,2)-1) = [];
    temp_grid(:,size(grid,2)*2+2:end) = [];
    
    %}
    
    %iterate only through interior (original grid)
    for j = 2:size(grid, 1)+1
        for k = 2:size(grid, 2)+1
            num_neighbors = find_neighbors(j, k, temp_grid);
            
            %live cells
            if grid(j-1, k-1) && ((num_neighbors > 3) || (num_neighbors < 2))
                grid(j-1, k-1)  = ~grid(j-1, k-1);
            end
            
            %dead cells
            if (num_neighbors == 3) && ~grid(j-1, k-1)
                grid(j-1, k-1) = ~grid(j-1, k-1);
            end
            
        end
    end
    
end
end

function num_neighbors = find_neighbors(j, k, temp_grid)
num_neighbors = sum(sum(temp_grid(j-1:j+1,k-1:k+1)));
if temp_grid(j, k) == 1
    num_neighbors = num_neighbors - 1; 
end
end
