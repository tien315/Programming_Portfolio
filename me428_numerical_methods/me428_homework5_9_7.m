%Alan Tieng
%ME428 Numerical Methods
%Homework 5

%% 9.7
clear all;
close all;
clc;

s1 = heun('fe1',0,180,473.15,60);
plot(s1(:,1),s1(:,2))
xlabel('Time (s)')
ylabel('Temperature (K)')
title('Temperature vs. Time')

%	 HEUN'S METHOD FOR SOLVING A FIRST-ORDER ODE
%
function s = heun(f,a,b,ya,h)
%
%	 f is the function entered as a string 'f'
%	 a and b are the starting and end points
%	 ya is the initial condition y(1)
%	 h is the step size
%	 s[t' y'] is the output where t is the vector of
%	 independent variable and y is the vector of dependent
%	 variable
%
m = (b-a)/h;
t = zeros(1,m + 1);
y = zeros(1,m + 1);
t = a:h:b;
y(1) = ya;
disp("Problem 9.7");
disp(" ");
for j = 1:m
    k1 = feval(f,t(j),y(j));
    k2 = feval(f,t(j + 1),y(j) + h*k1);
    y(j + 1) = y(j) + (h/2)*(k1 + k2);
end
s = [t' y']
end

function z = fe1( x,y )
r = 0.025;
rho = 9000;
C = 400;
ee = 0.5;
sig = 5.67*10^-8;
T_f = 298.15;
h = 15;
z = -(ee*sig*(y^4-T_f^4)+h*(y-T_f))/(rho*C*r/3);
end