close all
clear all
clc

F0 = 0.294; %amplitude of forcing
phi = 0; %phase
x = linspace(0,0.00001);   % time scale
k = 39.9; %spring constant in N/m
m = 0.021625; %mass in kg
w = sqrt(k/m); %natural freq in rad/s
zai = 0.01;
c = zai*2*sqrt(m*k); %damping in Nms
wd = w*sqrt(1-zai^2);

x0=0; %initial condition position
v0=0; %initial condition velocity



ft = @(t) F0/k*(1-exp(-zai*w*t)/sqrt(1-zai^2)*cos(wd*t-atan(zai/sqrt(1-zai^2))));
fplot(ft, [0,1])

