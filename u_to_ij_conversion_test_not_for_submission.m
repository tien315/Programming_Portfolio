close all;
clear all;
clc;

%% User input

readFileName = input('Input filename: ', "s");
writeFileName = input('Output filename: ', "s");

%% Parse Text

fid = fopen(readFileName);
text = textscan(fid, '%s%s%s%s%s', 'Delimiter', ' ', 'MultipleDelimsAsOne', true, 'TextType', 'string', 'ReturnOnError', false);
fclose(fid);

G = text{1};
x = text{2};
y = text{3};
U = text{4};
f = text{5};

for i = 1:size(G,1)
   if (G{i} == "G2") || (G{i} == "G3")
       mIndex = i-1;
       while true
           if ~isempty(x{mIndex})   
               break;
           end
           mIndex = mIndex-1;
       end
       startCoord = findCoord(x,y,mIndex);
       endCoord = findCoord(x,y,i);
       newCenter = findNewCenter(startCoord, endCoord, str2double(regexp(U{i},'[-\d.]+','match')),i);

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
    coord(1) = str2double(regexp(x{i},'[\d.]+','match'));
    coord(2) = str2double(regexp(y{i},'[\d.]+','match'));
    return
end

% This function calculates the intersections of two equal radius circles.
% Output newCenter = [G2 x, G2 y; G3 x, G3 y]
function [newCenter] = findNewCenter(startCoord, endCoord, U, iteration)

disp(iteration)

    %formulae for 2 circle intersection modified for circles with equal R
    d = sqrt((endCoord(1)-startCoord(1))^2+(endCoord(2)-startCoord(2))^2);
    d = floor(d*1000)/1000;
    x = (d^2)/(2*d);
    y = sqrt((4*d^2*abs(U)^2-(d^2)^2)/(4*d^2));
    theta = atand((endCoord(2)-startCoord(2))/(endCoord(1)-startCoord(1)));

    if (endCoord(1) < startCoord(1))
        theta = theta + 180;
    end

    %Tranformation matrix
    Q = [cosd(theta), -sind(theta); sind(theta), cosd(theta)];
    
    if U < 0
        center1 = Q*[x;-y];
        center2 = Q*[x;y];
    else    
        center1 = Q*[x;y];
        center2 = Q*[x;-y];
    end

    
    for i = 1:2
        if abs(center1(i))<0.0005
            center1(i) = 0;
        end
        if abs(center2(i))<0.0005
            center2(i) = 0;
        end
    end
    
    newCenter = round([center2';center1'], 3);    

    return
end