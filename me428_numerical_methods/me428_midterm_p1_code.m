%Alan Tieng
%ME428 Numerical Methods
%Midterm Problem 1

%% 1

clear all;
close all;
clc;

matrix = load('p1Matrix.mat');
j_out = jordan(matrix.output(:,1:end-1),matrix.output(:,end));
r_out = rref(matrix.output);
r_out = r_out(:,end);
diff_out = j_out - r_out;

disp("Gauss-Jordan result:")
for i = 1:length(j_out')
    disp("x"+num2str(i)+" = " + num2str(j_out(i,1)))
end
disp(" ");
disp("rref() result:")
for i = 1:length(r_out')
    disp("x"+num2str(i)+" = " + num2str(r_out(i,1)))
end
disp(" ");
disp("Difference:")
for i = 1:length(diff_out')
    disp("x"+num2str(i)+" = " + num2str(diff_out(i,1)))
end

function [x,tr] = jordan(a,b)
   
    [n n] = size(a);
    x = zeros(n,1);
    c = zeros(1,n + 1);
    aug = [a b];
    
    %Partial Pivoting
    for p = 1:n
        [y,j] = max(abs(aug(p:n,p)));
        c = aug(p,:);
        aug(p,:) = aug(j + p-1,:);
        aug(j + p-1,:) = c;

        %Check if coefficient matrix is singular
        if aug(p,p) ==0
            disp("a was singular. No unique solution");
            break
        end

        %Apply Gauss–Jordan method
        for k = p + 1:n + 1
            aug(p,k) = aug(p,k)/aug(p,p);
        end

        aug(p,p) = 1;

        for i = 1:n
            if i ~=p
                for j = p + 1:n + 1
                    aug(i,j) = aug(i,j)-aug(i,p)*aug(p,j);
                end
                aug(i,p) = 0;
            end
        end
    end

    %Output solution
    tr = aug(1:n,1:n);
    x = aug(:,n + 1);
end

