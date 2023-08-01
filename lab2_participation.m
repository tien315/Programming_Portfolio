close all;
clear all;
clc;

x = [0:0.01:2*pi];
y = sin(x);

%add 4 additional customizations to plot
plot(x, y, 'Color', 'red', 'LineStyle', '--', 'Linewidth', .25,...
    'Marker', 'o', 'MarkerIndices', [1:50:length(x)],...
    'MarkerFaceColor', 'k');

%add 4 additional items from 'Titles and Labels'
xlabel('x');
ylabel('y');
title('sin(x)');
legend('sin(x)');

%add 5 additional items from 'Axes Limits and Aspect Ratios'
xlim([0 2*pi]);
ylim([-1 1]);
grid on;
box off;
daspect([1 2 2]);
