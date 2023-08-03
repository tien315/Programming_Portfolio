%Alan Tieng
%ME428 Numerical Methods
%Homework 8 Problem 7.28

%%
clear all;
close all;
clc;

y = [146 129.5 114.8 90.3 85.1 63 34.6 25.6 14.1];
x = [0.2 0.6 1.0 1.8 2.0 3.0 5.0 6.0 8.0];

r1 = sum(x);
r2 = sum(x.^2);
r3 = sum(log(y));
r4 = sum(x.*log(y));
r5 = length(x);

s1 = [r3 r1; r4 r2];
s2 = [r5 r1; r1 r2];
s3 = [r5 r3; r1 r4];
s4 = [r5 r1; r1 r2];
a = exp(det(s1)/det(s2));
b = det(s3)/det(s4);

fprintf('The value of constant C is %f \n',a);
fprintf('The value of c is %f \n',b);
fprintf('T = %f * exp(%f*t) \n',a,b);

polyfit(x,y,1)

