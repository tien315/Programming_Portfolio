%Project 1 - Water Resources
%Alan Tieng
%CS 109, Spring 2020, Reckinger

clear all
close all
clc

%calculates fresh water, total water and determines greatest source and
%percentage.

types = ["rainfall", "lakes", "aquifers", "reservoirs", "rivers"];
volumes = [119000,91000,10000000,5000,2120]; %km^3
volumes = volumes * 2.641721 * (10^11); %into gallons
totalFreshWater = sum(volumes);
globalWater = totalFreshWater/0.005; %fresh water is 0.5% of global water

fprintf('The total amount of available fresh water is %G gallons \n', ...
    totalFreshWater);
fprintf('The total amount of water on earth is %G gallons \n', ...
    globalWater);

percentage = volumes / totalFreshWater * 100;
[maxPercentage,maxIndex] = max(percentage);
maxSource = types(maxIndex);

disp(maxPercentage + "% of available and usable fresh water comes " + ...
    "from " + maxSource + ".");