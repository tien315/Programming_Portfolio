clear all;
close all;

%Part 1
%{ 
2*4*3.14;
radius = 4; %in
diameter = 2*radius;
circumference = pi*diameter;
%}
r = 5; %in
h = 12; %in
vol = pi * (r^2) * (h/3);
%314.1593 in^3

%Part 2
R1 = 5; %ohm
R2 = 10; %ohm
ER = ((R1^-1)+(R2^-1))^-1;