%Project 2 - Plotting
%Alan Tieng
%CS 109, Spring 2020, Reckinger

clear all;
close all;
clc;

mindist=[2.71 4.25 0.92 0.03 0.79 1.22 4.84 1.16]; %km
maxdist=[84.07 248.54 269.4 283.54 294.96 515.89 3975.58 6115.71]; %km
avdist=[18.4 79.46 101.24 27.15 46.33 92.36 1246.15 1713.57]; %km
time=[500 30 300 450 5000 15 100 100]; %years
ghg=[0.001 0.004 0.005 0.001 0.002 0.005 0.066 0.091]; %MTCE/us ton
types=["glass", "wood", "computer", "plastic", "styrofoam", "wood", ...
    "battery", "cartridge"];
ghg_highlight = .05;
time_highlight = 400;

subplot(3,1,1);
hold all;
grid on;
plot(mindist, 'r--o', 'LineWidth', 2, 'MarkerSize', 6);
plot(maxdist, 'b--s', 'LineWidth', 2, 'MarkerSize', 6);
plot(avdist, 'g--d', 'LineWidth', 2, 'MarkerSize', 6);
title('Distances different types of trash travel')
xlabel('Type of Trash');
ylabel('Distance, km');
xticklabels(types);
legend('minimum distance', 'maximum distance', 'average distance', ...
    'Location', 'northwest');

subplot(3,1,2);
hold all;
grid on;
plot(ghg, 'sk', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
plot(find(ghg  > ghg_highlight), ghg(ghg > ghg_highlight), 'or',...
    'MarkerSize', 25, 'LineWidth', 2); %circle ghg values > ghg_highlight
title('Greenhouse gas emissions from various types of trash');
xlabel('Type of Trash');
ylabel('GHG, MTCE/us ton');
xticklabels(types);

subplot(3,1,3);
hold all;
grid on;
plot(time, '*g', 'MarkerSize', 20);
plot(find(time > time_highlight), time(time > time_highlight), 'or',...
    'MarkerSize', 25, 'LineWidth', 2); %circle time values > time_highlight
title('Time to decompose of various types of trash');
xlabel('Type of Trash');
ylabel('Time, years');
xticklabels(types);
ylim([0, 6000]); %to match dimensions of example photo