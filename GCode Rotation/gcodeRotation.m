close all;
clear all;
clc;

% User input
theta = input('Degrees of rotation: ');
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

% Calculate new points
for i = 1:size(G,1)

   %transform X and Y
   if (isMovement(G{i}, "movement")) 
       %Extract position as double from string
       oldPos = [findExp(x,i); findExp(y,i); 1];
       %Transform
       posPrime = transformC(oldPos, originPrime, theta);
       x{i} = convertStringsToChars("X"+num2str(posPrime(1)));
       y{i} = convertStringsToChars("Y"+num2str(posPrime(2)));
   end

   %Transform I and J if applicable
   if (isMovement(G{i}, "circular movement")) && (size(text,2) > 4)
       ch = convertStringsToChars(U(i));
       cy = convertStringsToChars(f(i));
       if (ch(1) == "I" || ch(1) == "i") && (cy(1) == "J" || cy(1) == "j")
           %Extract position as double from string
           oldPos = [findExp(U,i); findExp(f,i); 1];
           %Transform
           posPrime = transformC(oldPos, originPrime, theta);
           U{i} = convertStringsToChars("I"+num2str(posPrime(1)));
           f{i} = convertStringsToChars("J"+num2str(posPrime(2)));
       end
   end

   %Append spaces to last lines (M30 or M31)
   if i==size(G,1)
       x{i} = ' ';
       y{i} = ' ';
       U{i} = ' ';
       f{i} = ' ';    
   end
end

rawToFile = [G,x,y,U,f]';

% Write to file
fid = fopen(writeFileName, 'w');
fprintf(fid, '%s %s %s %s %s\n', rawToFile);
fclose(fid);

% Functions

%--------------------------------------------------------------------------
% Numbers in the dataset are stored as a string combined with letters (ex.
% X101.2568 or U-0.303).  This function separates the number and converts 
% it into a double as the output.
% Inputs:
% vec - cell, containing the values of a column of the original file (such 
%       as all X coordinates).
% i - integer, a value of the current iteration of the loop that called 
%       this function, referring to a location in the cell vec.
% Outputs:
% foundExp - double, the numbers extracted from the string found at vec{i}.
%--------------------------------------------------------------------------
function foundExp = findExp(vec, i)
    foundExp = str2double(regexp(vec{i},'[\d.\-]+','match'));
    return
end

%--------------------------------------------------------------------------
% This function transforms coordinates based on a given angle and point of
% rotation.
% Inputs:
% oldPos - double (1 x 3), original position of the point to be 
%           transformed.
% originPrime - double (1 x 2), the point at which the rotation will occur.
% theta - double, the angle of rotation in degrees.
% Outputs:
% primeCoord - double (1 x 3), the coordinate after rotation.
%--------------------------------------------------------------------------
function posPrime = transformC(oldPos, originPrime, theta)
    %Rotation matrix
    Q = [cosd(theta), -sind(theta), 0; sind(theta), cosd(theta), 0; ...
        0, 0, 1];
    
    %Translation matrix
    T = [1, 0, originPrime(1); 0, 1, originPrime(2); 0, 0, 1];
    
    %Rotate and find new coordinates
    oldPos = T*oldPos;
    posPrime = (Q)*oldPos;
    posPrime = (T^-1)*posPrime;
end

%--------------------------------------------------------------------------
% This function checks if the string is a movement command.
% Inputs:
% gString - string
% checkType - string, identifies call for movement or circular movement
%             check.
% Outputs:
% movement - bool
%--------------------------------------------------------------------------
function movement = isMovement(gString, checkType)
  switch checkType
      case "movement"
          checkList = ["G00" "G01" "G02" "G03" "G0" "G1" "G2" "G3"];
      case "circular movement"
          checkList = ["G02" "G03" "G2" "G3"];
  end
  movement = false;
  for i = 1:length(checkList)
    if strcmp(checkList(i), gString)
      movement = true;
      break;
    end
  end
end
