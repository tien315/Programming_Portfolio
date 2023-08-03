%Alan Tieng
%ME428 Numerical Methods
%Homework 3
%Problem 6.16

%% 6.16
% Solve the following system of linear equations using Gaussian elimination
% and also Gauss–Jordan elimination, both being employed with and without
% partial pivoting: 
%
%         x_1 + 2*x_2 + 4*x_3 = 18
%       2*x_1 + 3*x_2 - 5*x_3 = -18
%       4*x_1 -   x_2 -   x_3 = -14
%
% Compare the results obtained with each other and with the analytical
% solution. Does pivoting improve the accuracy of the results?

clear all;
close all;
clc;
%Enter input data

a = [1 2 4;2 3 -5;4 -1 -1];
b = [18 -18 -14]';
disp("The solution for #6.16 is: ");
[x, tr] = jordan(a,b)

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