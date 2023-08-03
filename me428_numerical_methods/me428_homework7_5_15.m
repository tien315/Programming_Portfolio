%Alan Tieng
%ME 428 Numerical Methods
%Homework 7 Problem 5.13


clear all;
close all;
clc;

syms f_f
Re = [10^4 10^6];
f = @(f_f) (2*log(Re(1).*f_f.^0.5)-0.8)-1./f_f.^0.5;
f2 = @(f_f) (2*log(Re(2).*f_f.^0.5)-0.8)-1./f_f.^0.5;

subplot(2,1,1)
sgtitle("Re = 10^4")
fplot(f,[0 0.1])
hold on
fplot(0,[0 0.1])
title("f(f)")
ylabel("f")
xlabel("friction factor")
subplot(2,1,2)
fplot(f,[0.005 0.008])
hold on
fplot(0,[0.005 0.008])
title("f(f)")
ylabel("f")
xlabel("friction factor")

figure;
subplot(2,1,1)
sgtitle("Re = 10^6")
fplot(f2,[0 0.1])
hold on
fplot(0,[0 0.1])
title("f(f)")
ylabel("f")
xlabel("friction factor")
subplot(2,1,2)
fplot(f2,[0.002 0.0025])
hold on
fplot(0,[0.002 0.0025])
title("f(f)")
ylabel("f")
xlabel("friction factor")

%% search method

disp("Applying Search Method");
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
%
% 	 Enter starting values
%
disp("For Re = 10^4")
eps = .02;
for i = 1:6
    x = 0;
    dx = 0.1;
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
            f_1 = f(x);
            x = x + dx;
            f_2 = f(x);
            a = f_1*f_2;
        end
        fprintf('X = %.5f   F1 = %10.4f     F2 = %10.4f\n',x,f_1,f_2)
        %
        % 	 Reduce increment size
        %
        dx1 = dx;
        x = x-dx;
        dx = dx/10;
        f_1 = f(x);
        x = x + dx;
        f_2 = f(x);
        a = f_1*f_2;
    end
    %
    % 	 Print numerical results
    %
    fprintf('ROOT = %.8f    F(X) = %.8f\n\n',x,f_1)
    %
    % 	 Vary convergence parameter
    %
    eps = eps/10;
end

disp("For Re = 10^6")
eps = .02;
for i = 1:6
    x = 0;
    dx = 0.1;
    dx1 = dx;
    a = f2(x)*f2(x);
    fprintf('EPS = %.5f\n',eps)
    %
    % 	 Check for convergence to the root
    %
    while dx1 > eps
        %
        % 	 Check for sign change in f(x)
        %
        while a > 0
            f_1 = f2(x);
            x = x + dx;
            f_2 = f2(x);
            a = f_1*f_2;
        end
        fprintf('X = %.5f   F1 = %10.4f     F2 = %10.4f\n',x,f_1,f_2)
        %
        % 	 Reduce increment size
        %
        dx1 = dx;
        x = x-dx;
        dx = dx/10;
        f_1 = f2(x);
        x = x + dx;
        f_2 = f2(x);
        a = f_1*f_2;
    end
    %
    % 	 Print numerical results
    %
    fprintf('ROOT = %.8f    F(X) = %.8f\n\n',x,f_1)
    %
    % 	 Vary convergence parameter
    %
    eps = eps/10;
end


%% newton-raphson method

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
fprintf('EPS= %.8f\n',eps);
disp("For Re = 10^4");
%
% 	 Enter starting value of the root
%
x(1) = input('Enter the initial guess, x(1) = ');
%
% 	 Apply Newton-Raphson method
%
for i = 1:20
    fprintf('X= %.8f    FUNCTION F(X)= %0.8f\n',x(i),f(x(i)));
    fd = (f(x(i) + 0.00001)-f(x(i)))/0.00001;
    x(i + 1) = x(i) - f(x(i))/fd;
    %
    % 	 Check for convergence and print results
    %
    if (abs(x(i + 1)-x(i)) <= eps)
        fprintf('X= %.8f  FUNCTION F(X)= %.8f\n',x(i + 1),f(x(i + 1)));
        break;
    end
end

disp(" ");
fprintf('EPS= %.8f\n',eps);
disp("For Re = 10^6");
%
% 	 Enter starting value of the root
%
x(1) = input('Enter the initial guess, x(1) = ');
%
% 	 Apply Newton-Raphson method
%
for i = 1:20
    fprintf('X= %.8f    FUNCTION F(X)= %0.8f\n',x(i),f2(x(i)));
    fd = (f2(x(i) + 0.001)-f2(x(i)))/0.001;
    x(i + 1) = x(i) - f2(x(i))/fd;
    %
    % 	 Check for convergence and print results
    %
    if (abs(x(i + 1)-x(i)) <= eps)
        fprintf('X= %.8f  FUNCTION F(X)= %.8f\n',x(i + 1),f2(x(i + 1)));
        break;
    end
end
disp(" ");

%% bisection method

%	 BISECTION METHOD FOR FINDING THE ROOTS OF AN ALGEBRAIC
%	 EQUATION
%
% This program finds the real roots of the equation
%	 f(x) = 0 by the Bisection method
%
%	 eps is the convergence parameter; fa, fb and fc are
%	 values of the function f(x) at the two ends, a and b,
%	 of the domain containing the root and at the mid point,
%	 respectively.
%
disp("Applying Bisection Method");
format short
eps = 0.00001;
fprintf('EPS= %.5f\n',eps);
disp("For Re = 10^4")
%
% 	 Enter limits of the domain
%
a = input('Enter lowest value of interval, a = ');
b = input('Enter highest value of interval, b = ');
%
% 	 Apply Bisection method
%
for i = 1:40
    fa = f(a);
    fb = f(b);
    c(i) = (a + b)/2;
    fc = f(c(i));

    %
    %	 Check for convergence
    %

    if(abs(fc) <= eps)
        fprintf('Iteration converged \n')
        break
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
fprintf('X= %.8f \n', c(end))

clear c;
disp(" ")
disp("For Re = 10^6")
%
% 	 Enter limits of the domain
%
a = input('Enter lowest value of interval, a = ');
b = input('Enter highest value of interval, b = ');
%
% 	 Apply Bisection method
%
for i = 1:40
    fa = f2(a);
    fb = f2(b);
    c(i) = (a + b)/2;
    fc = f2(c(i));

    %
    %	 Check for convergence
    %

    if(abs(fc) <= eps)
        fprintf('Iteration converged \n')
        break
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
fprintf('X= %.8f \n', c(end))