clear all;
close all;
clc;

m = input('For an m x n matrix, input m: ');
n = input('For an m x n matrix, input n: ');
matrix = zeros(m,n);
for i = 1:m
    for j = 1:n
        matrix(i,j) = input(['Input element in position (', num2str(i), ',', num2str(j), '): ']);
    end
end
opt = input('rref, rref2inverse or inverse?', 's');
matrix
switch opt
    case 'rref'
        rref(matrix)
    case 'rref2inverse'
        rref_matrix = rref(matrix)
        if (m^2) ~= sum(eye(m) == rref_matrix(:,1:m))
            if (m^2) ~= sum(eye(m) == rref_matrix(:,1:m))
                disp("No inverse with this matrix.");
            end
        end
    case 'inverse'
        inv(matrix)
    otherwise
        disp("Invalid option.")
end

        
        