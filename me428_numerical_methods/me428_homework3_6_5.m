%Alan Tieng
%ME428 Numerical Methods
%Homework 3
%Problem 6.5


%% 6.5
% A third-order polynomial of the form y = Ax^3 + Bx^2 + Cx + D is to be
% fitted to four time-velocity data points. At time x = 0, 1, 2, and 3 s,
% the velocity is measured as 7, 14, 29, and 58 m/s. Using Gauss–Jordan
% elimination, find the curve that passes through these points. Also, solve
% the problem by employing the backslash operator in MATLAB and compare the
% results with those obtained earlier.

clear all;
close all;
clc;

%Code from page 518-519 of Jaluria, formatted and debugged for use here.

% GAUSSIAN ELIMINATION METHOD FOR SOLVING
% A SYSTEM OF LINEAR EQUATIONS
%
%	 a is the coefficient matrix, b the constant vector, x
%	 the vector of unknowns and tr the transformed upper
%	 triangular matrix
%
% 	 Input data
%
a = [0 0 0 1; 1 1 1 1; 8 4 2 1; 27 9 3 1];
b = [7 14 29 58]';
disp("The solution for #6.5 is: ");
x = gauss(a,b)

function [x,tr] = gauss(a,b)
    [n n] = size(a);
    x = zeros(n,1);
    c = zeros(1,n + 1);

    %Form the augmented matrix
    aug = [a b];

    %Partial pivoting
    for p = 1:n-1
        [y,j] = max(abs(aug(p:n,p))); %finding the max value element for each pivot row.
        c = aug(p,:);
        aug(p,:) = aug(j + p-1,:); %changing row location
        aug(j + p-1,:) = c;
        
        %Check if matrix is singular
        if aug(p,p) ==0
            disp("a was singular. No unique solution");
            break
        end
    
        %Obtain upper triangular matrix
        for k = p + 1:n
            m = aug(k,p)/aug(p,p);
            aug(k,p:n + 1) = aug(k,p:n + 1)-m*aug(p,p:n + 1);
        end
    end
    
    %Apply back-substitution
    tr = aug(1:n,1:n);
    x = backsub(aug(1:n,1:n),aug(1:n,n + 1));

    %Back Substitution
    function x = backsub(a,b)
        n = length(b);
        x = zeros(n,1);
        x(n) = b(n)/a(n,n);
            for k = n-1:-1:1
            x(k) = (b(k)-a(k,k + 1:n)*x(k + 1:n))/a(k,k);
            end
    end
end