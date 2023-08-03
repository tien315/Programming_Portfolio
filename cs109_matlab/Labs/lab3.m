%Lab 3 - Branches
%Alan Tieng
%CS 109, Spring 2020, Reckinger
close all;
clear all;
clc;
 
%requesting input from user, second parameter 's' is to accept make
%the variable units hold strings.  If the user is entering in 
%numeric values, the 's' can be left out of the function call.
units = input('Enter units for making plot (miles, ft, ft/hr): ', 's');  

time = [1:10]; %hrs
distance = [65 136 189 210 225 362 433 483 575 660]; %distances in miles
 
%Test your code in Zybooks by copy and pasting only code you write below
%this line
 
%TODO: write your code here

switch units
    case "miles"
        y = distance; 
        plot_options = '*--r'; %red star, dashed line
        marker_size = 20;
        line_width = 2;
        plot_title = "Road Trip";
        x_axis_label = "Time, hours";
        y_axis_label = "Distance, miles";
        x_min = min(time);
        x_max = max(time);
    case "ft"
        y = distance * 5280; %convert to ft
        plot_options = '^-m'; %magenta up triangle, solid line
        marker_size = 20;
        line_width = 2;
        plot_title = "Road Trip";
        x_axis_label = "Time, hours";
        y_axis_label = "Distance, ft";
        x_min = min(time);
        x_max = max(time);
    case "ft/hr"
        y = (distance * 5280) ./ time; %calculate ft/hr
        plot_options = 'o:c'; %cyan circle, dotted line
        marker_size = 20;
        line_width = 2;
        plot_title = "Road Trip";
        x_axis_label = "Time, hours";
        y_axis_label = "Speed, ft/hr";
        x_min = min(time);
        x_max = max(time);
    otherwise
        y = []; %invalid input, empty array
end

if (~isempty(y)) %check valid input
    plot(time, y, plot_options, 'MarkerSize', marker_size,...
        'LineWidth', line_width);
    grid on;
    title(plot_title);
    xlabel(x_axis_label);
    ylabel(y_axis_label);
    xlim([x_min x_max]);
else
    figure %intentional, display blank figure
end