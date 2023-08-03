%Project 8 - Food Deserts
%Alan Tieng
%CS 109, Spring 2020, Reckinger

%use no built in functions except length and numel
clear all;
close all;
clc;

%INPUTS:
%-opt - the label of the dataset to pull from CookCountyFoodInsecurity.mat
%OUTPUTS:
%-corrcoef1 - 
%-corrcoef2 - 
function [corrcoef1, corrcoef2] = analyze_it(opt)
load('CookCountyFoodInsecurity.mat');
color_val = [69 140 204]./255;
plot_option = '.';
switch opt
    case 'low income'
        x1 = povertyRate./100;
        y1 = lowIncomeFoodDesert./population;
        x2 = lowIncomeFoodDesert./population;
        y2 = withoutCars./population;
        corrcoef1 = corrcoef_mine(x1,y1);
        corrcoef2 = corrcoef_mine(x2,y2);
    case 'black'
        x1 = povertyRate./100;
        y1 = blackFoodDesert./population;
        x2 = blackFoodDesert./population;
        y2 = withoutCars./population;
        corrcoef1 = corrcoef_mine(x1,y1);
        corrcoef2 = corrcoef_mine(x2,y2);
    case 'white'
        x1 = povertyRate./100;
        y1 = whiteFoodDesert./population;
        x2 = whiteFoodDesert./population;
        y2 = withoutCars./population;
        corrcoef1 = corrcoef_mine(x1,y1);
        corrcoef2 = corrcoef_mine(x2,y2);
    case 'asian'
        x1 = povertyRate./100;
        y1 = asianFoodDesert./population;
        x2 = asianFoodDesert./population;
        y2 = withoutCars./population;
        corrcoef1 = corrcoef_mine(x1,y1);
        corrcoef2 = corrcoef_mine(x2,y2);
    case 'hispanic'
        x1 = povertyRate./100;
        y1 = hispanicFoodDesert./population;
        x2 = hispanicFoodDesert./population;
        y2 = withoutCars./population;
        corrcoef1 = corrcoef_mine(x1,y1);
        corrcoef2 = corrcoef_mine(x2,y2);
end
subplot(2,1,1)
plot(x1,y1,plot_option,'Color', color_val);
title({"Correlation coefficient = " + corrcoef1, "(" + opt + ")"});
xlabel("% population in district below poverty line", 'FontSize', 9);
ylabel({"% population in district who are " + opt + " and",...
    "live >0.5 mile away from supermarket"}, 'FontSize', 9);
subplot(2,1,2);
plot(x2,y2,plot_option,'Color', color_val);
title({"Correlation coefficient = " + corrcoef2, "(" + opt + ")"});
xlabel({"% population in district who are " + opt + " and",...
    "live >0.5 mile away from supermarket"}, 'FontSize', 9);
ylabel({"% population in district who", "do not have access to a car"},...
    'FontSize', 9);
end

%Calculate correlation between x and y of specified dataset;
%INPUTS:
%-x - x dataset
%-y - y dataset
%OUTPUTS:
%-corr_coef_xy - the correlation between the data and y data
function [corr_coef_xy] = corrcoef_mine(x,y)
%verify dataset match
if length(x)~=length(y)
    corr_coef_xy = 0;
    disp("The x and y datasets are not of equal length.");
    return
end
%means
mean_x = 0;
mean_y = 0;
%standard deviations
sx = 0;
sy = 0;
%number of datapoints
n = length(x);
covariance = 0;
%calulate means
for i = 1:n
    mean_x = x(i)/n + mean_x;
    mean_y = y(i)/n + mean_y;
end
%calculate standard deviations and covariance
for i = 1:n
    sx = sx + ((x(i)-mean_x)^2)/(n-1);
    sy = sy + ((y(i)-mean_y)^2)/(n-1);
    covariance = covariance + ((x(i)-mean_x)*(y(i)-mean_y)/(n-1));
end
sx = sx^(1/2);
sy = sy^(1/2);
corr_coef_xy = (covariance/(sx*sy));
end