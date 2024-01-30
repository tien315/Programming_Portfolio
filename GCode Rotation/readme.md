close all;
clear all;
clc;


%Gcode rotation

%%TODO
%add code for rotation about a point other than the origin
%T(x,y)*R*T(-x,-y)*P = P'

%% User input

theta = input('Degrees of rotation: ');
readFileName = input('Input filename: ', "s");
writeFileName = input('Output filename: ', "s");

% Parse Text and calculate new center points

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

%%
for i = 1:size(G,1)
   if (G{i} == "G0" || G{i} == "G1" || G{i} == "G2") || (G{i} == "G3" ...
           || G{i} == "G01" || G{i} == "G02") || (G{i} == "G03")
       
       %Extract position as double from string
       xPos = findExp(x,i);
       yPos = findExp(y,i);
       
       %Rotation matrix
       Q = [cosd(theta), -sind(theta); sind(theta), cosd(theta)];

       %Rotate about origin and find new coordinates
       posPrime = (Q^-1)*[xPos;yPos];

       x{i} = convertStringsToChars("X"+num2str(posPrime(1)));
       y{i} = convertStringsToChars("Y"+num2str(posPrime(2)));
   end
   
   %append spaces to last lines
   if i==size(G,1)
       f{i} = ' ';
       x{i} = ' ';
       y{i} = ' ';
       U{i} = ' ';
   end

end

rawToFile = [G,x,y,U,f]';

%% Write to file
fid = fopen(writeFileName, 'w');
fprintf(fid, '%s %s %s %s %s\n', rawToFile);
fclose(fid);

%% Functions

% Numbers in the dataset are stored as a string combined with letters (ex.
% X101.2568 or U-0.303).  This function separates the number and converts 
% it into a double as the output.
function foundExp = findExp(vec, i)
    foundExp = str2double(regexp(vec{i},'[\d.\-]+','match'));
    return
end
