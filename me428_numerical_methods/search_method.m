% SEARCH METHOD FOR FINDING THE ROOTS OF AN ALGEBRAIC EQUATION
%
% This program finds the real roots of the equation
%	 f(x) = 0 by the incremental search method
%
% Here, eps is the convergence parameter, dx the
%	 increment in x, dx1 the increment at sign change of
%	 f(x), and f1 and f2 the values of the function f(x) at
%	 two consecutive x values
%
% 	 Define function f(x)
%

close all;
clear all;
clc;

f = inline('0.8*5.67*10^(-8)*(1000^4-x^4)-50*(x-500)-(25/0.15)*(x-300)');
%
% 	 Enter starting values
%


eps = 10.0;
for i = 1:6
x = 300;dx = 50;
dx1 = dx;
a = f(x)*f(x);
fprintf('EPS = %.5f\n',eps)
%
% 	 Check for convergence to the root
%
	 while dx1 > eps
%
% 	 Check for sign change in f(x)
%
while a > 0
f1 = f(x);
x = x + dx;
f2 = f(x);
a = f1*f2;
end
fprintf('X = %.5f	 	 	 	 F1 = %10.4f	 	 	 	 F2 = %10.4f\n',x,f1,f2)
%

% 	 Reduce increment size
%
dx1 = dx;
	 x = x-dx;
	 dx = dx/10;
f1 = f(x);
x = x + dx;
f2 = f(x);
a = f1*f2;
end
%
% 	 Print numerical results
%
	 	 	 fprintf('TEMPERATURE = %.5f	 	 	 	 F(X) = %.4f\n\n',x,f1)
%
% 	 Vary convergence parameter
%
	 	 	 eps = eps/10;
end