%Lab 1 - Arrays
%Alan Tieng
%CS 109, Spring 2020, Reckinger

%The two lines below should be uncommented while developing in MATLAB
%Keep them commented while testing in Grader
clear all
clear all
clc

radius = 4; %meters
height = 6; %meters
volume = pi * radius^2 * height; %m^3

radii = [3:3:30]; %meters
radii(5) = 7.4;
radii([8, 9, 10]) = [9, 9, 9];
diameters = radii * 2; 
volumes = radii.^2 * pi * height; %m^3
costs = (32430 ./radii) + (radii * 428 * pi); %$

subplot(2, 1, 1);
plot(radii, volumes, 's');
xlabel("Radius (m)");
ylabel("Volume (m^3)");
title("Tanks: Volume vs. Radius");
subplot(2, 1, 2);
plot(radii, costs, 'o');
xlabel("Radius (m)");
ylabel("Cost ($)");
title("Tanks: Cost vs. Radius");