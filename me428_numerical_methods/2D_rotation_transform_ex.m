clear all;
close all;
clc;

theta = 90;
Q = [cosd(theta), -sind(theta); sind(theta), cosd(theta)];

xt = 0;
yt = 1;

c = Q*[xt,yt]';