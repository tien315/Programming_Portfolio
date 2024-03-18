# Conversion of U to I-J Circular Interpolation in G-Code

This script takes an .nc file, parses it for G02 or G03 commands, calculates centerpoints for I-J interpolations, then rewrites the file.

In Matlab:

```Matlab
close all;
clear all;
clc;

% User input
%readFileName = input('Input filename: ', "s");
%writeFileName = input('Output filename: ', "s");
readFileName = 'original.nc';
writeFileName = 'modified.nc';


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

for i = 1:size(G,1)
   if (isMovement(G{i}, "circular movement"))
       
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

       if (isMovement(G{i}, "CCW"))
           U{i} = convertStringsToChars("I"+num2str(newCenter(2,1)));
           f{i} = convertStringsToChars("J"+num2str(newCenter(2,2)));
       else
           U{i} = convertStringsToChars("I"+num2str(newCenter(1,1)));
           f{i} = convertStringsToChars("J"+num2str(newCenter(1,2)));
       end
   end
end
% Pad the columns
% x = [x; " "];
% y = [y; " "];
% U = [U; " "];
% f = [f; " "];
rawToFile = [G,x,y,U,f]';

% Write to file
fid = fopen(writeFileName, 'w');
fprintf(fid, '%s %s %s %s %s\n', rawToFile);
fclose(fid);

% Functions 

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function [coord] = findCoord(x,y,i)
    coord(1) = findExp(x, i);
    coord(2) = findExp(y, i);
    return
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
      case "CCW"
          checkList = ["G03" "G3"];
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

%--------------------------------------------------------------------------
% Numbers in the dataset are stored as a string combined with letters (ex.
% X101.2568 or U-0.303).  This function separates the number and converts 
% it into a double as the output.
%--------------------------------------------------------------------------
function foundExp = findExp(vec, i)
    %foundExp = str2double(regexp(vec{i},'[\d.]+','match'));
    foundExp = vec{i};
    foundExp = str2double(foundExp(2:end));
    return
end

%--------------------------------------------------------------------------
% This function calculates the intersections of two equal radius circles.
% Output is in the form: newCenter = [G2 x, G2 y; G3 x, G3 y]
% Input:
% startCoord - double (1 x 2)
% endCoord - double (1 x 2)
% U - double
% iteration - int
% Output:
% newCenter - double (2 x 1)
%--------------------------------------------------------------------------
function [newCenter] = findNewCenter(startCoord, endCoord, U)
    % Find distance between start and end points
    d = sqrt((endCoord(1)-startCoord(1))^2+(endCoord(2)-startCoord(2))^2);
    
    % keep d/2 < U when rounding error occurs (ex. d = 0.6066, U = 0.3033
    % when rounded to 3 decimals, d = 0.607 and U = 0.303. The line below
    % turns d into 0.606 instead by truncation.)
    d = floor(d*1000)/1000;
    
%     % Check the distance between the start and end are not more than the 
%     % specified radius.
%     if d > abs(U)
%         disp("Error, distance between start and end points is greater" +...
%             "than the radius specified. Please check line " + ...
%             num2str(iteration))
%         return
%     end
    
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
        G2 = Q*[x;y];
        G3 = Q*[x;-y];
    else 
        G2 = Q*[x;-y];
        G3 = Q*[x;y];
    end
    newCenter = round([G2'; G3'], 3);        
    return
end

```

In Python:

```Python
import pandas as pd
import numpy as np
import math


# Functions
def is_movement(g_string, move_type):
    if move_type == "CCW":
        check_list = ["G03", "G3"]
    elif move_type == "circular movement":
        check_list = ["G02", "G03", "G2", "G3"]
    else:
        check_list = [0]
    movement = False
    for i_loc in range(len(check_list)):
        if check_list[i_loc] == g_string:
            print('circle')
            movement = True
            break
    return movement


def find_coord(x, y, index):
    coord = [find_exp(x, index), find_exp(y, index)]
    return coord


def find_new_center(st_coord, ed_coord, u_val, iteration):
    # Find distance between start and end points

    d = math.sqrt(math.pow(ed_coord[0] - st_coord[0], 2) + math.pow(ed_coord[1] - st_coord[1], 2))
    # Keep d / 2 < U when rounding error occurs(ex.d = 0.6066, U = 0.3033 when rounded to 3 decimals, d = 0.607 and
    # U = 0.303.The line below turns d into 0.606 instead by truncation.)
    d = math.floor((d * 1000)) / 1000
    print(d)
    print(u_val)
    # Check the distance between the start and end are not more than the specified radius.
    if d/2 > abs(u_val):
        print(f"Error, distance between start and end points is greater than the radius specified. Please check "
              f"line " + str(iteration))
        return

    x = d / 2
    y = math.sqrt(math.pow(u_val, 2) - math.pow(d / 2, 2))
    # avoid domain error, div by 0
    theta = math.atan((ed_coord[1] - st_coord[1]) / (ed_coord[0] - st_coord[0] + 0.0000000000000001))

    if ed_coord[0] < st_coord[0]:
        theta = theta + math.pi
    # Transformation matrix
    q_rot = np.array([[math.cos(theta), -math.sin(theta)], [math.sin(theta), math.cos(theta)]])

    # U values < 0 indicate an arc tracing > 180 degrees, so we need to flip the center used.
    if u_val < 0:
        G2 = q_rot @ np.array([[x], [y]])
        G3 = q_rot @ np.array([[x], [-y]])
    else:
        G2 = q_rot @ np.array([[x], [-y]])
        G3 = q_rot @ np.array([[x], [y]])

    n_center = np.array([[round(G2[0, 0], 3), round(G2[1, 0], 3)],
                        [round(G3[0, 0], 3), round(G3[1, 0], 3)]])
    print(n_center)
    return n_center


def find_exp(vec, index):

    temp = vec[index]
    temp = temp[1:-1]
    temp = float(temp)
    return temp


nameFileIn = input("Enter the name of the file you want to modify: ")
# f = open(nameFileIn, 'r', encoding="utf-8")
# text = f.read()
# f.close()

data = pd.read_csv(nameFileIn, sep=" ", header=None, names=["G", "X", "Y", "U", "F"])

for i in range(len(data.G)):

    if is_movement(data.G[i], "circular movement"):
        print(i)
        m_index = i-1
        while True:
            if isinstance(data.X[m_index], str):
                break
            m_index = m_index-1
        start_coord = find_coord(data.X, data.Y, m_index)
        end_coord = find_coord(data.X, data.Y, i)
        print(start_coord)
        print(end_coord)
        new_center = find_new_center(start_coord, end_coord, find_exp(data.U, i), i)
        if is_movement(data.G[i], "CCW"):
            # data.loc["U", i] = str(f"I" + str(new_center[0, 0]))
            # data.loc["F", i] = str(f"J" + str(new_center[1, 0]))
            data.U[i] = str(f"I" + str(new_center[1, 0]))
            data.F[i] = str(f"J" + str(new_center[1, 1]))
        else:
            # data.loc["U", i] = str(f"I" + str(new_center[0, 1]))
            # data.loc["F", i] = str(f"J" + str(new_center[1, 1]))
            data.U[i] = str(f"I" + str(new_center[0, 0]))
            data.F[i] = str(f"J" + str(new_center[0, 1]))
newFileName = nameFileIn[0:len(nameFileIn)-3]+"_modified.nc"
data.to_csv(newFileName, sep=" ", encoding='utf-8', index=False, header=False)

```
