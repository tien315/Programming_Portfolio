close all;
clear all;
clc;


%Gcode rotation

%% User input

theta = input('Degrees of rotation: ');;
originPrime(1) = -input('Point of rotation X: ');
originPrime(2) = -input('Point of rotation Y: ');
readFileName = input('Input filename: ', "s");
writeFileName = input('Output filename: ', "s");

% Parse Text

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

%% Calculate new points
for i = 1:size(G,1)
   if (G{i} == "G0" || G{i} == "G1" || G{i} == "G2") || (G{i} == "G3" ...
           || G{i} == "G01" || G{i} == "G02") || (G{i} == "G03")
       
       %Extract position as double from string
       oldPos = [findExp(x,i); findExp(y,i); 1];

       %Rotation matrix
       Q = [cosd(theta), -sind(theta), 0; sind(theta), cosd(theta), 0;...
           0, 0, 1];

       %Translation matrix
       T = [1, 0, originPrime(1); 0, 1, originPrime(2); 0, 0, 1];

       %Rotate and find new coordinates
       oldPos = T*oldPos;
       posPrime = (Q)*oldPos;
       posPrime = (T^-1)*posPrime;

       x{i} = convertStringsToChars("X"+num2str(posPrime(1)));
       y{i} = convertStringsToChars("Y"+num2str(posPrime(2)));
   end
   
   %append spaces to last lines (M30 or M31)
   if i==size(G,1)

       x{i} = ' ';
       y{i} = ' ';
       U{i} = ' ';
       f{i} = ' ';
       
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
