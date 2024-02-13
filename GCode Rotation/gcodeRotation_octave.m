close all;
clear all;
clc;

% Functions

%-------------------------------------------------------------------------------
% Numbers in the dataset are stored as a string combined with letters (ex.
% X101.2568 or U-0.303).  This function separates the number and converts
% it into a double as the output.
% Inputs:
% vec - cell, containing the values of a column of the original file (such as all
%       X coordinates).
% i - integer, a value of the current iteration of the loop that called this
%     function, referring to a location in the cell vec.
% Outputs:
% foundExp - double, the numbers extracted from the string found at vec{i}.
function foundExp = findExp(vec, i)
    foundExp = str2double(regexp(vec{i},'[\d.\-]+','match'));
    return
end
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
% This function transforms coordinates based on a given angle and point of
% rotation.
% Inputs:
% oldPos - double (1 x 3), original position of the point to be transformed.
% originPrime - double (1 x 2), the point at which the rotation will occur.
% theta - double, the angle of rotation in degrees.
% Outputs:
% primeCoord - double (1 x 3), the coordinate after rotation.
function primeCoord = transformC(oldPos, originPrime, theta)
    %Rotation matrix
    Q = [cosd(theta), -sind(theta), 0; sind(theta), cosd(theta), 0; 0, 0, 1];
    %Translation matrix
    T = [1, 0, originPrime(1); 0, 1, originPrime(2); 0, 0, 1];
    %Rotate and find new coordinates
    oldPos = T*oldPos;
    primeCoord = (Q)*oldPos;
    primeCoord = (T^-1)*primeCoord;
end
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
% This function looks at the first letter of the string and determines if a new
% line is needed.  Letters such as I or Y are part of a single line in G-code,
% usually with a new line beginning with a G command such as G01.
% Inputs:
% firstLetter - char, first letter of the string located in the current cell of
%               the read text file.
% Outputs:
% newLine - bool, indicates if a new line is needed.
function newLine = isNewLine(firstLetter)
  checkList = ["X" "Y" "x" "y" "I" "J" "i" "j" "U" "R" "u" "r" "F" "f"];
  newLine = false
  for i = 1:length(checkList)
    i
    if checkList(i) == firstLetter
      newLine = true
      break;
    endif
  endfor
end
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
% This function checks if the string is a movement command.
% Inputs:
% gString - string
% Outputs:
% movement - bool
function movement = isMovement(gString)
  checkList = ["G00" "G01" "G02" "G03" "G0" "G1" "G2" "G3"];
  movement = false;
  for i = 1:length(checkList)
    if strcmp(checkList(i), gString);
      movement = true;
      break;
    endif
  endfor
end
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
% This function checks if the string is a circular movement command.
% Inputs:
% gString - string
% Outputs:
% circleCom - bool
function circleCom = isCircleCom(gString)
  checkList = ["G02" "G03" "G2" "G3"];
  circleCom = false;
  for i = 1:length(checkList)
    if strcmp(checkList(i), gString);
      circleCom = true;
      break;
    endif
  endfor
end
%-------------------------------------------------------------------------------

% User input
theta = input('Degrees of rotation: ');;
originPrime(1) = -input('Point of rotation X: ');
originPrime(2) = -input('Point of rotation Y: ');
readFileName = input('Input filename: ', "s");
writeFileName = input('Output filename: ', "s");

% Dump text into a single column cell
fid = fopen(readFileName);
text = textscan(fid, '%s', 'delimiter', ' ');
fclose(fid);

% Unpack cell
text = text{1};

% Sort and place
col = 1;
row = 0;
for i = 1:length(text)
  temp = text{i};
  if length(text{i})~=0
    if (isNewLine(temp(1)))
      col = col + 1;
    else
      row = row + 1;
      col = 1;
    endif
    newText{row, col} = text{i};
  endif
end
clear text;

% Divide columns
G = newText(:,1);
x = newText(:,2);
y = newText(:,3);
if size(newText,2) > 4
   U = newText(:,4);
   f = newText(:,5);
endif

% Calculate new points
for i = 1:size(G,1)
   if isMovement(G(i))
      %Extract position as double from string
      oldPos = [findExp(x,i); findExp(y,i); 1];
      %Transform coordinates for X and Y
      posPrime = transformC(oldPos, originPrime, theta);
      x(i) = ["X" num2str(posPrime(1))];
      y(i) = ["Y" num2str(posPrime(2))];
   endif
   % Transform I and J coordinates if applicable
   if isCircleCom(G(i)) && (size(newText,2) > 4)
      ch = U{i};
      cy = f{i};
      if (ch(1) == "I" || ch(1) == "i") && (cy(i) == "J" || cy(i) == "j")
         %Extract position as double from string
         oldPos = [findExp(U,i); findExp(f,i); 1];
         %Transform coordinates for I and J
         posPrime = transformC(oldPos, originPrime, theta);
         U(i) = ["I" num2str(posPrime(1))];
         f(i) = ["J" num2str(posPrime(2))];
      endif
   endif
end

newText(:,2) = x(:);
newText(:,3) = y(:);
if size(newText,2) > 4
   newText(:,4) = U(:);
   newText(:,5) = f(:);
endif
newText = newText';

% Write to file
fid = fopen(writeFileName, 'w');

switch size(newText,1)
  case 3
    fprintf(fid, '%s %s %s\n', newText{:});
  case 4
    fprintf(fid, '%s %s %s %s\n', newText{:})
  case 5
    fprintf(fid, '%s %s %s %s %s\n', newText{:});
  case 6
    fprintf(fid, '%s %s %s %s %s %s\n', newText{:});
endswitch

fclose(fid);
