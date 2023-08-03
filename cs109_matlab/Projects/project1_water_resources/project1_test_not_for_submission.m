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
globalWater = totalFreshWater/0.005;

fprintf('The total amount of available fresh water is %d gallons \n', ...
    totalFreshWater);
fprintf('The total amount of water on earth is %d gallons \n', ...
    globalWater);

percentage = volumes / totalFreshWater * 100;
[maxPercentage,maxIndex] = max(percentage);
maxSource = types(maxIndex);

disp(maxPercentage + "% of available and usable fresh water comes " + ...
    "from " + maxSource + ".");

%ignore this testing sprintf and floating point formatting
%{
fprintf('The total amount of available fresh water is %.3G gallons \n', ...
    totalFreshWater);
fprintf('The total amount of water on earth is %.3G gallons \n', ...
    globalWater);
%}

%{
cleanOutput = sprintf(...
    '%f%% of available and usable fresh water comes from %s.', ...
    maxPercentage,maxSource);
disp(cleanOutput);
cleanOutput = sprintf(...
    '%E%% of available and usable fresh water comes from %s.', ...
    maxPercentage,maxSource);
disp(cleanOutput);
cleanOutput = sprintf(...
    '%G%% of available and usable fresh water comes from %s.', ...
    maxPercentage,maxSource);
disp(cleanOutput);
%}