# Conversion of U to I-J Circular Interpolation in G-Code

This script takes an .nc file, parses it for G02 or G03 commands, calculates centerpoints for I-J interpolations, then rewrites the file.

> This has only been tested on .nc files formatted for use with [Leister](https://www.leister.com/en/Laser-Systems) laser welders.

```Matlab
close all;
clear all;
clc;

%% User input

readFileName = input('Input filename: ', "s");
writeFileName = input('Output filename: ', "s");

%% Parse Text and calculate new center points

fid = fopen(readFileName);
text = textscan(fid, '%s%s%s%s%s', 'Delimiter', ' ', ...
    'MultipleDelimsAsOne', true, 'TextType', 'string', ...
    'ReturnOnError', false);
fclose(fid);

G = text{1};
x = text{2};
y = text{3};
U = text{4};
f = text{5};

for i = 1:size(G,1)
   if (G{i} == "G2") || (G{i} == "G3")
       
       %find the start coordinates
       mIndex = i-1;
       while true
           if ~isempty(x{mIndex})   
               break;
           end
           mIndex = mIndex-1;
       end
       
       startCoord = findCoord(x,y,mIndex); %[x,y]
       endCoord = findCoord(x,y,i); %[x,y]
       newCenter = findNewCenter(startCoord, endCoord, findExp(U, i));

       if (G{i} == "G2")
           U{i} = convertStringsToChars("I"+num2str(newCenter(1,1)));
           f{i} = convertStringsToChars("J"+num2str(newCenter(1,2)));
       else
           U{i} = convertStringsToChars("I"+num2str(newCenter(2,1)));
           f{i} = convertStringsToChars("J"+num2str(newCenter(2,2)));
       end
   end
end

rawToFile = [G,x,y,U,f]';

%% Write to file
fid = fopen(writeFileName, 'w');
fprintf(fid, '%s %s %s %s %s\n', rawToFile);
fclose(fid);

%% Functions 

function [coord] = findCoord(x,y,i)
    coord(1) = findExp(x, i);
    coord(2) = findExp(y, i);
    return
end

% Numbers in the dataset are stored as a string combined with letters (ex.
% X101.2568 or U-0.303).  This function separates the number and converts 
% it into a double as the output.
function foundExp = findExp(vec, i)
    foundExp = str2double(regexp(vec{i},'[\d.\-]+','match'));
    return
end

% This function calculates the intersections of two equal radius circles.
% Output newCenter = [G2 x, G2 y; G3 x, G3 y]
function [newCenter] = findNewCenter(startCoord, endCoord, U, iteration)

disp(iteration)

    % Find distance between start and end points
    d = sqrt((endCoord(1)-startCoord(1))^2+(endCoord(2)-startCoord(2))^2);
    
    % keep d/2 < U when rounding error occurs (ex. d = 0.6066, U = 0.3033
    % when rounded to 3 decimals, d = 0.607 and U = 0.303. The line below
    % turns d into 0.606 instead by truncation.)
    d = floor(d*1000)/1000;
    
    % Check the distance between the start and end are not more than the 
    % specified radius.
    if d > abs(U)
        disp(['Error, distance between start and end points is greater' ...
            'than the radius specified. Please check line ' + ...
            num2str(iteration)])
        return
    end

    x = d/2;
    y = sqrt(U^2-(d/2)^2);
    theta = atand((endCoord(2)-startCoord(2))/(endCoord(1)-startCoord(1)));

    if (endCoord(1) < startCoord(1))
        theta = theta + 180;
    end

    % Tranformation matrix
    Q = [cosd(theta), -sind(theta); sind(theta), cosd(theta)];
    
    % U values < 0 indicate an arc tracing > 180 degrees so we need to flip
    % the center used.
    if U < 0
        center1 = Q*[x;-y];
        center2 = Q*[x;y];
    else    
        center1 = Q*[x;y];
        center2 = Q*[x;-y];
    end
    
    newCenter = round([center2'; center1'], 3);    

    return
end
```
