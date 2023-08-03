%Alan Tieng
%ME428 Numerical Methods
%Homework 8 Problem 7.13

%%

clear all;
close all;
clc;

v = [0.9 1.75];
y = [10:10:80];
x = [0.391 0.789 1.196 1.611 2.035 2.467 2.908 3.357];

n = length(x)-1;
a = zeros(4*n,4*n);
c = zeros(1,4*n);
itr = 0;
itr2 = 1;
itrd1 = 1;
itrd2 = 1;
itrbound = 0;
disp("With Code:")
for j = 1:4:n*4-3
    itr = itr + 1;
    a(itr,j+3) = 1;
    a(itr,j+2) = x(itr2);
    a(itr,j+1) = x(itr2)^2;
    a(itr,j) = x(itr2)^3;
    c(itr) = y(itr2);
    itr = itr + 1;
    itr2 = itr2 + 1;
    a(itr,j+3) = 1;
    a(itr,j+2) = x(itr2);
    a(itr,j+1) = x(itr2)^2;
    a(itr,j) = x(itr2)^3;
    c(itr) = y(itr2);
end

for j = 1:4:n*4-7
    itr = itr+1;
    itrd1 = itrd1+1;
    a(itr,j+3) = 0;
    a(itr,j+2) = 1;
    a(itr,j+1) = 2*x(itrd1);
    a(itr,j) = 3*x(itrd1)^2;
    
    a(itr,j+7) = 0;
    a(itr,j+6) = -1;
    a(itr,j+5) = -2*x(itrd1);
    a(itr,j+4) = -3*x(itrd1)^2;   
    
end
for j = 1:4:n*4-7
    itr = itr+1;
    itrd2 = itrd2+1;
    a(itr,j+3) = 0;
    a(itr,j+2) = 0;
    a(itr,j+1) = 2;
    a(itr,j) = 6*x(itrd2);
    
    a(itr,j+7) = 0;
    a(itr,j+6) = 0;
    a(itr,j+5) = -2;
    a(itr,j+4) = -6*x(itrd2);   
end
a(end-1,2) = 2;
a(end, end-2) = 2;
a(end, end-3) = 6*x(end);
c = c';

[coeff, ~] = jordan(a,c);

for i = 1:length(v)
    %locate index
    for j = 1:n
        if j ==1 && v(i) < x(j)
            disp("Out of range")
            break;
        end
        if v(i) > x(j) && v(i) < x(j+1)
            index = j;
            break;
        end
        if j == n && v(i) > x(j)
            disp("Out of range")
            break;
        end
    end

    start = 4*index-3;
    interp_val = coeff(start+3)+ coeff(start+2)*v(i) +...
        coeff(start+1)*v(i)^2 + coeff(start)*v(i)^3;
    fprintf('The interpolated value for V = %f is T = %f \n',v(i),interp_val);

end
disp(" ");
disp("With interp1() function:")
interp1(x,y,v,'spline')
%%
function [x,tr] = jordan(a,b)
   
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

    %Output solution
    tr = aug(1:n,1:n);
    x = aug(:,n + 1);
end