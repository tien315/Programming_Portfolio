
clear all;
close all;
clc;

load('CookCountyFoodInsecurity.mat');
pearson_coef(povertyRate./100,(lowIncomeFoodDesert./population))%corr 0.48258
%pearson
function [pearson_r] = pearson_coef(x,y)
%verify dataset match
if length(x)~=length(y)
    pearson_r = 0;
    disp("The x and y datasets are not of equal length.");
    return
end
n = length(x);
mean_x = mean(x);
mean_y = mean(y);
varx = (x-mean_x);
vary = (y-mean_y);
var = [1:n];
for i= 1:n
    var(i) = varx(i)*vary(i);
end
std(x)
std(y)
var = sum(var)/(n-1);
pearson_r = (var/(std(x)*std(y)));
end