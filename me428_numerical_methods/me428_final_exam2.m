%Alan Tieng
%ME428 Numerical Methods
%Final Exam Problem 2

clear all;
close all;
clc;

%% Do not edit this part
% It reads the matrix from the excel file and creates your x and y arrays
a = readmatrix('me428_final_exam2.csv');
x = a(:,1);
y = a(:,2);

%% Write your code here to calculate the MLS for a 2nd-order polynomial.
% The system must be solved by any method you programmed (please note if
% reusing code from another assignment, such as the take-home midterm).



poly_order = 2;

[n, ~] = size(a);

%generate LHS matrix
LHS = zeros(poly_order+1,poly_order+1);
for i = 1:poly_order+1
    for j = 1:poly_order+1
        LHS(i,j) = sum(a(:,1).^(j+i-2));
    end
end
LHS(1,1) = n;

%generate RHS matrix
RHS = zeros(1,poly_order+1);
for i = 1:poly_order+1
    RHS(i) = sum(a(:,2).*a(:,1).^(i-1));
end
RHS = RHS';

c = jordan(LHS,RHS)

%generate polynomial curve equation
poly_curve = char(num2str(c(1)));
for i = 2:poly_order+1
   poly_curve = [poly_curve '+' char(num2str(c(i))) '.*x.^' char(num2str(i-1))];
end

f = eval(['@(x)' poly_curve])

%% This section plots the original data and your result on a plot that must be submitted.
% I use the variables c(1), c(2), and c(3) to store the constants in the
% polynomial. You can edit this if needed

plot(x,y,'o') % plots the original data, do not edit
hold on

%plot(x,c(1)+c(2).*x+c(3).*x.^2,'LineWidth',2) % edit if needed

fplot(f,[a(1,1),a(end,1)],'LineWidth',2)

legend('Given data','Fit polynomial') % leave this line
text(.1,70,char(java.lang.System.getProperty('user.name'))) % leave this line, proves your work
text(.1,65,char(java.net.InetAddress.getLocalHost.getHostName)) % leave this line, proves your work


%This function was modified from a function found on page 521 of Jaluria
%and last used in homework assignment 4, problem 6.16.

%This function jordan solves a system of equations using the Gauss-Jordan
%Method of elimination with partial pivoting.
%INPUTS
%a - matrix containing the coefficients
%b - vector containing constants
%OUTPUT
%x - vector containing the computed solution.
function x = jordan(a,b)
   
    [n, ~] = size(a);
    aug = [a b];
    
    %Partial Pivoting
    for p = 1:n
        [~,j] = max(abs(aug(p:n,p)));
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

    %Output solution;
    x = aug(:,n + 1);
end