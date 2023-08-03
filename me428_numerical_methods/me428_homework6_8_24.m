%Alan Tieng
%ME428 Numerical Methods
%Homework 6 Problem 8.24

clear all;
close all;
clc;

p = [0 0.1  0.2  0.4  0.5  0.8  0.9  1.0 ; 
     4 4.23 4.53 5.34 5.88 8.03 8.96 10  ];
a = 0.5; %m^2

%Full trapezoidal
I = 0;
for i = 1:length(p)-1
   I = I + (p(2,i)+p(2,i+1))/2 *(p(1,i+1)-p(1,i)); 
end
fprintf('Trapezoidal:   n = %4g   Integral = %.4f \n',7,I*.5);

%Combination trapezoidal and simpsons

I_trap = 0;
for i = 3:5
   I_trap = I_trap + (p(2,i)+p(2,i+1))/2 *(p(1,i+1)-p(1,i)); 
end

I_simp = (p(2,1)+4*p(2,2)+p(2,3))*(0.1/3)+(p(2,end-2)+4*p(2,end-1)+p(2,end))*(0.1/3);

I = I_trap + I_simp;

fprintf('Combination:   n = %4g   Integral = %.4f \n',7,I*.5);
