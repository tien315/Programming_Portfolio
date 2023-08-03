%Alan Tieng
%ME 428 Numerical Methods
%Homework 7 Problem 5.13

%% 
clear all;
close all;
clc;

%% plot function

syms T;
f = @(T) (0.6*5.67*10^-8)*(850^4-T.^4)-4.0*(T-350);
subplot(2,1,1)
fplot(f, [0 1000]);
hold on
grid on
fplot(0)
title("f(T)")
ylabel("f")
xlabel("T")
subplot(2,1,2)
fplot(f, [800 850]);
hold on
grid on
fplot(0, [800 850])
title("f(T)")
ylabel("f")
xlabel("T")


%% regula falsi

%guess between 825 < alpha < 828


%	 REGULA FALSI METHOD FOR FINDING THE ROOTS OF AN ALGEBRAIC
%	 EQUATION
%
% This program finds the real roots of the equation
%	 f(x) = 0 by the Regula Falsi method
%
%	 eps is the convergence parameter; fa, fb and fc are
%	 values of the function f(x) at the two ends, a and b,
%	 of the domain containing the root and at the intersection point,
%	 respectively.
%
format short
disp("Applying the Regula Falsi Method");
eps = 0.02;
%
% 	 Enter limits of the domain
%
a = input('Enter lowest value of interval, a = ');
b = input('Enter highest value of interval, b = ');
%
% 	 Apply Regula Falsi method
%

for i = 1:40
    fa = f(a);
    fb = f(b);
    c(i) = (a*f(b)-b*f(a))/(f(b)-f(a));
    fc = f(c(i));

    %
    %	 Check for convergence
    %

    if(abs(fc) <= eps)
        disp('Iteration converged. Root:')
        break;
    end

    %
    % 	 Next iteration
    %
    if(fa*fc < 0)
        b = c(i);
    else
        a = c(i);
    end
end
c = c';
%
%	 Print results
%
disp(c(end))

%% matlab root finding

disp("Applying Matlab Root Finding Method");
solution = double(solve((0.6*5.67*10^-8)*(850^4-T.^4)-4.0*(T-350)==0,T))

%% newton-raphson

disp("Applying Newton-Raphson Method");
% NEWTON–RAPHSON METHOD FOR ROOT SOLVING
%
% Given equation: f(x) = 0
%
%	 eps is the convergence parameter, fd is the derivative
%	 of the function at the present approximation x(i), and
%	 the next approximation to the root is x(i + 1)
%
%f = inline('294*w*(1 - exp(-1000/(21*(5 + 20*w)))) - 250');
%
% 	 Enter convergence parameter
%
eps = input('Enter the convergence parameter, eps = ');
fprintf('EPS= %.4f\n',eps);
%
% 	 Enter starting value of the root
%
x(1) = input('Enter the initial guess, x(1) = ');
%
% 	 Apply Newton-Raphson method
%
for i = 1:20
    fprintf('X= %.4f    FUNCTION F(X)= %0.6f\n',x(i),f(x(i)));
    fd = (f(x(i) + 0.001)-f(x(i)))/0.001;
    x(i + 1) = x(i) - f(x(i))/fd;
    %
    % 	 Check for convergence and print results
    %
    if (abs(x(i + 1)-x(i)) <= eps)
        fprintf('X= %.4f  FUNCTION F(X)= %.6f\n',x(i + 1),f(x(i + 1)));
        break;
    end
end




