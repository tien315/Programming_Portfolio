%%Project 10 - Tour de France Data Analysis
%%Alan Tieng
%%Spring 2020, CS 109, Reckinger

clear all;
close all;
clc;


%row 1:filename, row 2:name    
stage = ["Stage12", "Stage16", "Stage17", "Stage19"; ...
    "Stage 12", "Stage 16", "Stage 17", "Stage 19"];

%loop through and produce a figure for each stage
for i = 1:length(stage)
    
    load(['TDF', char(stage(1,i)), '.mat']);
    [total_distance, vertical_speed] = processData(stage(2,i), time, speed, elev);

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%INPUT parameters:
%%--stage_name - a string used for labeling, e.g. stage = "Stage 12"
%%--time (hr), time that speed and elevation data is collected. You can
%%assume data is collected at consistent intervals (e.g. every minute, or
%%every half minute, etc.)
%%--speed (km/hr), speed of racer at each time 
%%--elevation (m), elevation of racer at each time 
%%OUTPUT parameters:
%%--total_distance - approximate the distance of the race by numerically
%%integrating the speed data.  This is a single number.
%%--vertical_speed - approximate the vertical speed of the racer by
%%numerically differentiating the elevation data.  This is an array that
%%will be the same as the elev array.  
function [total_distance, vertical_speed] = processData(stage_name, time, speed, elevation)
    
    %integrate with trapezoid method
    total_distance = 0; %meters
    for i = 1:length(time)-1
       total_distance = total_distance + (speed(i)+speed(i+1))/2 * (time(i+1)-time(i)); 
    end
    
    vertical_speed = elevation; %init vertical_speed to elevation dimensions
    
    %forward diff for first point
    vertical_speed(1) = (elevation(2) - elevation(1)) ./ (time(2) - time(1));
    
    %central diff for interior points
    for i=2:length(time)-1
        vertical_speed(i) = (elevation(i-1) - elevation(i+1))./(time(i-1) - time(i+1));
    end
    
    %rear diff for end point
    vertical_speed(end) = (elevation(end) - elevation(end-1)) ./ (time(end) - time(end-1));
    
    figure;
    subplot(2,1,1)
    %print speed (primary) and elevation (secondary) on same plot
    [hAx] = plotyy(time, speed, time, elevation); 
    ylabel(hAx(1), "Speed (km/hr)");
    ylabel(hAx(2), "Elevation (m)");
    title("Speed and Elevation for " + stage_name);
    xlim(hAx(1), [0 time(end)]);
    xlim(hAx(2), [0 time(end)]);
    xticks(hAx(1), 0:time(end));
    xticks(hAx(2), 0:time(end));
    ylim(hAx(1), [0 100]);
    ylim(hAx(2), [0 2500]);
    yticks(hAx(1), 0:20:100);
    yticks(hAx(2), 0:500:2500);
     
    subplot(2,1,2)
    plot(time, vertical_speed, 'r-');
    ylabel("Vertical Speeds (m/hr)");
    title("Vertical Speeds");
    disp("Total distance of " + stage_name + " is: " + total_distance +" km.");
    xlim([0 time(end)])
    xticks([0:1:time(end)]);
    ylim([-10000 2000]);
    yticks(-10000:2000:2000);
end
