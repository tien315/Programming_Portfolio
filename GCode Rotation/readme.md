# Rotation of a contour in GCode

This script rewrites the positions of a contour based on user input in degrees of rotation.

> This has only been tested on .nc files formatted for use with [Leister](https://www.leister.com/en/Laser-Systems) laser welders.

```Matlab
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
```

Written for Octave

```Octave
close all;
clear all;
clc;

%% Functions

% Numbers in the dataset are stored as a string combined with letters (ex.
% X101.2568 or U-0.303).  This function separates the number and converts
% it into a double as the output.
function foundExp = findExp(vec, i)
    foundExp = str2double(regexp(vec{i},'[\d.\-]+','match'));
    return
end

%Gcode rotation

%% User input

theta = input('Degrees of rotation: ');;
originPrime(1) = -input('Point of rotation X: ');
originPrime(2) = -input('Point of rotation Y: ');
readFileName = input('Input filename: ', "s");
writeFileName = input('Output filename: ', "s");

% Parse Text

text = textread(readFileName, '%s', 'delimiter', ' ');
col = 1;
row = 0;

for i = 1:length(text)
  temp = text{i};
  if length(temp)~=0
    if (temp(1) =='X' || temp(1) =='Y' || temp(1) =='I' || temp(1) =='J' ||...
        temp(1) =='x' || temp(1) =='y' || temp(1) =='i' || temp(1) =='j' ||...
        temp(1) =='U' || temp(1) =='R' || temp(1) =='F' || temp(1) =='u' ||...
        temp(1) =='r' || temp(1) =='f')
      col = col+1
    else

      row = row + 1
      col = 1
    endif
    newText{row, col} = temp;
  endif

end

G = newText(:,1);
x = newText(:,2);
y = newText(:,3);
if size(newText, 2) == 4
  U = newText(:,4);
endif
if size(newText,2) == 5
  f = newText(:,5);
endif


%% Calculate new points
for i = 1:size(G,1)
   if (strcmp(G(i), "G0") || strcmp(G(i), "G1") || strcmp(G(i), "G2") || ...
           strcmp(G(i), "G3") || strcmp(G(i), "G01") || strcmp(G(i), "G02")...
           || strcmp(G(i), "G03"))

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

       x(i) = ["X" num2str(posPrime(1))];
       y(i) = ["Y" num2str(posPrime(2))];
   end

end

newText(:,2) = x(:);
newText(:,3) = y(:);
newText = newText'

%% Write to file
fid = fopen(writeFileName, 'w');
fprintf(fid, '%s %s %s %s\n', newText{:});
fclose(fid);
```
