%Alan Tieng
%ME428 Numberical Methods
%Homework 6 Problem 8.8

clear all;
close all;
clc;

%Analytical Calculation
syms t;
f = @(t) (125+50*sin(2*pi/24*(t-6))-25)*200;
ff = @(t) 20000+10000*sin(pi/12*t-pi/2);
I = integral(ff,6,12);
fprintf('Analytical:    n = %4g    Integral = %.4f \n',6,I);

%Trapezoidal Rule
u = 6:12;
for i = 6:12
    u(i-5) = feval(ff,i);
end
dy = 1;
I = 0;
for i = 1:length(u)-1
   I = I + (u(i)+u(i+1))/2 *dy; 
end
fprintf('Trapezoidal:   n = %4g   Integral = %.4f \n',6,I);

%Simpsons Rule
simp(ff,6,12,6);
% NUMERICAL INTEGRATION BY SIMPSONS'S RULE
%
function s = simp(f,a,b,n)
%
% f is the function, entered as a string, a and b are the
%	 limits of integration, n is the number of subintervals,
%	 m is the number of two-segment intervals and s the sum
%	 or quadrature
%

%
% Calculate segment size h and number of two-segment
%	 sections m
%
h = (b-a)/n;
m = n/2;
%
% 	 Apply Simpson's rule
%
s1 = 0;
s2 = 0;
for k = 1:m
    x = a + h*(2*k-1);
    s1 = s1 + feval(f,x);
end
for k = 1:(m-1)
    x = a + h*2*k;
    s2 = s2 + feval(f,x);
end
s = h*(feval(f,a) + feval(f,b) + 4*s1 + 2*s2)/3;
%
% 	 Print results
%
fprintf('1/3 Simpsons:  n = %4g  Integral = %.4f \n',n,s);

end