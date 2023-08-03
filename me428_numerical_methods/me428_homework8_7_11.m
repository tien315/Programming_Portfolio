%Alan Tieng
%ME428 Numerical Methods
%Homework 8 Problem 7.11

%%
close all
clear all
clc

visc_sample = [1 1.1 1.3 1.4 1.6 1.7 2.0; 5 5.41 6.29 6.76 7.76 8.29 10]';
order = 2;

[f, c] = least_squares(visc_sample, order);

v_400_exact = 26.41*10^-6;
v_600_exact = 52.69*10^-6;

disp("The exact value at 400K is " + num2str(v_400_exact));
disp("The exact value at 600K is " + num2str(v_600_exact));
disp(" ");

v_400_mls = feval(f,400)*10^-6;
v_600_mls = feval(f,600)*10^-6;

disp("Using the least squares method with a polynomial order of " + num2str(order));
disp("The interpolated value at 400K is " + num2str(v_400_mls));
disp("Error: " + num2str(abs(v_400_exact-v_400_mls)/v_400_exact*100) + "%");
disp("The interpolated value at 600K is " + num2str(v_600_mls));
disp("Error: " + num2str(abs(v_600_exact-v_600_mls)/v_600_exact*100) + "%");

v_400_int = interp1(visc_sample(:,1),visc_sample(:,2),400)*10^-6;
v_600_int = interp1(visc_sample(:,1),visc_sample(:,2),600)*10^-6;

disp(" ")
disp("Using Matlab function interp1()");
disp("The interpolated value at 400K is " + num2str(v_400_int));
disp("Error: " + num2str(abs(v_400_exact-v_400_int)/v_400_exact*100) + "%");
disp("The interpolated value at 400K is " + num2str(v_600_int));
disp("Error: " + num2str(abs(v_600_exact-v_600_int)/v_600_exact*100) + "%");

%% functions
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

function [f, c] = least_squares(a, poly_order)

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

end