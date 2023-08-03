%Project 3 - Plotting with branches
%Alan Tieng
%CS 109, Spring 2020, Reckinger
 
clear all;
close all;
clc;
 
names = ["CENTRAL OVER S&S CAN","WACKER-MICHIGAN-RAND","RYAN SB RMP TO 55WB","1.3-2.6 MI SW OF I94","MICH.AVE-S.OF RIVER", "North to West Ramp","RIVER TO CANAL ST","RAMP 'G'","RANDOLPH-MICHIGAN-FI","55 EB RMP TO SB RYAN","LARAMIE    K2 AVE BR", "CANAL-HARRISON-TAYLO", "CANAL-MADISON-ADAMS"];
yearBuilt = [1970,1926,1962,1963,1921,2015,1962,2006,1937,1964,1956,1926,1926];
yearReconstruct = [2007,2002,1990,2000,1998,0,1989,0,1981,1997,1999,1983,1983];
score = [79,50,94.5,94,60.9,96,68,96,80.9,94.4,80.2,41.4,45.6];
 
opt = input('What would you like to plot (1-year built, 2-year reconstruct, 3-score?  ');
 
%TODO:  Write your code below
%When your program is functioning as expected, copy and paste the code below
%this line into the testing script on Zybooks.  Do not copy in anything
%above this line.

switch opt
    case 1
        y = yearBuilt;
        plot_options = 'vr'; % red downward triangle
        x_tick_labels = names;
        x_axis_label = "Bridges";
        y_axis_label = "Year Built";
        plot_line_width = 2;
    case 2
        y = yearReconstruct;
        y(y == 0) = NaN;
        plot_options = 'ob'; %blue circle
        x_tick_labels = names;
        x_axis_label = "Bridges";
        y_axis_label = "Year Reconstructed";
        plot_line_width = 2;
    case 3
        y = score;
        plot_options = '*g'; %green star
        x_tick_labels = names;
        x_axis_label = "Bridges";
        y_axis_label = "Overall Score";
        plot_line_width = 2;  
    otherwise
        y = [];
        disp("Invalid opt value, it must be either 1, 2, or 3");
end

%formatting x axis, gap to left and right of graph
x = [1:length(names)];
x_tick_angle = -45;
x_tick_indices = [1:length(x)];
x_lim = [0, length(y)+1]; %default lim for x < 15

%set y axis min and max to multiples of ten above and below data set
y_min = min(y) - rem(min(y),10);
y_max = max(y) - rem(max(y),10) + 10;
y_tick_indices = y_min:10:y_max;

if (~(isempty(y)))
    %if number of bridges > 15
    if (length(x) > 15)
        %clear bridge names and relabel xticks to [0:100x]
        x_max = max(x) - rem(max(x), 100) + 100;
        x_tick_labels = [0:100:x_max];
        x_tick_angle = 0;
        x_tick_indices = 0:100:x_max;
        x_lim = [0 x_max];
    end
    plot(x, y, plot_options,'LineWidth', plot_line_width);
    grid on;
    xlabel(x_axis_label);
    ylabel(y_axis_label);  
    yticks(y_tick_indices);
    xticks(x_tick_indices);
    xticklabels(x_tick_labels);
    xtickangle(x_tick_angle); 
    xlim([x_lim]);
else
    figure; %intentional, display blank figure
end