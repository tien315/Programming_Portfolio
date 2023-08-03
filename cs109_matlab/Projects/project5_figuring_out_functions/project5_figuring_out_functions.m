%Project 5 - Figuring out Functions
%Alan Tieng
%CS 109, Reckinger, Spring 2020

clear all;
close all;
clc;

namesSmall = ["CENTRAL OVER S&S CAN","WACKER-MICHIGAN-RAND","RYAN SB RMP TO 55WB","1.3-2.6 MI SW OF I94","MICH.AVE-S.OF RIVER", "North to West Ramp","RIVER TO CANAL ST","RAMP 'G'","RANDOLPH-MICHIGAN-FI","55 EB RMP TO SB RYAN","LARAMIE    K2 AVE BR", "CANAL-HARRISON-TAYLO", "CANAL-MADISON-ADAMS"];
yearBuiltSmall = [1970,1926,1962,1963,1921,2015,1962,2006,1937,1964,1956,1926,1926];
yearReconstructSmall = [2007,2002,1990,2000,1998,0,1989,0,1981,1997,1999,1983,1983];
scoreSmall = [79,50,94.5,94,60.9,96,68,96,80.9,94.4,80.2,41.4,45.6];

main(namesSmall, yearBuiltSmall, yearReconstructSmall, scoreSmall);  %this will run all code below.

%This is your main function for Project 5.  Only copy and paste code below
%this line for testing in Zybooks.
%Call the cleanData function on the yearReconstruct data
%Find the longest standing bridge
%Subplot 3 datasets
function main(names, yearBuilt, yearReconstruct, score)
close all;
[yearReconstruct] = cleanData(yearReconstruct);
oldest_ind = findOldestBridge(yearBuilt, yearReconstruct);
%plotIt(yearBuilt, "Year Built", 'rv', names, oldest_ind)

subplot(3,1,1);
plotIt(yearBuilt, "Year Built", 'rv', names, oldest_ind)
subplot(3,1,2);
plotIt(yearReconstruct, "Year Reconstructed", 'bo', names, oldest_ind)
subplot(3,1,3);
plotIt(score, "Overall Score", 'g*', names, oldest_ind)

end

%This function cleans that data.
%INPUTS:
%dataIn - a 1D array of data, any size
%OUTPUTS:
%dataOut - all data in dataIn that are zeros are set to NaN and returned
%via dataOut
%ct - stores the number of 0's in dataIn that are getting set to NaNs
function [dataOut, ct] = cleanData(dataIn)
ct = sum(dataIn == 0);
dataOut = dataIn;
dataOut(dataOut == 0) = NaN;
end

%This function finds the oldest bridge.  You may not use any built in
%functions (except length and isnan) to write this function.
%INPUTS:
%yearBuilt - an array of years that correspond with when each bridge was
%built
%yearReconstruct - an array of years that correspond with when each bridge
%was reconstructed (if a bridge has never been reconstructed, its year will
%be NaN)
%OUTPUTS:
%ind - the index location(s) of the oldest standing bridge.  For example, if
%your data was: yearBuilt = [1900 1910 1890] and yearReconstruct = [NaN
%1950 1980], then ind = 1--the oldest standing bridge is the first bridge 
%since it was originally built in 1900 and never reconstructed and the other 
%two bridges were reconstructed in 1950 and 1980.  For example, if your data
%was: yearBuilt = [1940 1960 1910] and yearReconstruct = [1950 1970 1920],
%then ind = 3--the oldest standin gbridge is the third bridge.  For
%example, if your data was: yearBuilt = [1925 1930 1915] and
%yearReconstruct = [1930 NaN 1956], then ind = [1, 2];
function [ind] = findOldestBridge(yearBuilt, yearReconstruct)
%create composite array combining latest dates from both arrays
composite_dates = yearReconstruct;
composite_dates(isnan(composite_dates)) = yearBuilt(isnan(composite_dates));
ind = 1;
%find earliest date, enter multiple entries for duplicates
for i = ind:length(composite_dates)
    if (composite_dates(i) < composite_dates(ind))
        ind = i;
    elseif composite_dates(i) == composite_dates(ind)
        ind = [ind, i];
    end
end
end

%This function should plot the data received as the first input.  The plot
%should also label x axis as "Bridges", label y axis using ystr, and
%customize the line using custom.  If the data sent in has less than or
%equal to 15 bridges, it should label the ticks with names and angle the
%x tick labels at -45 degrees.  This will on create one plot and will not
%call figure, subplot, or anything else (those will need to be called
%outside of this function).
%INPUTS:
%y - the data to plot on the y axis
%ystr - the string to label the y axis
%custom - the character array to customize the line
%names - the array of strings to label the x ticks
%indCircle = an array of integer indices that should be circled in the
%plot.  Increase the marker size, and set the marker to a red circle.
%Lastly, add a text annotation at each location that labels it as "Oldest
%Standing Bridge".
%OUTPUTS:
%a plot is produced when this function is called.
function plotIt(y, ystr, custom, names, indCircle)
plot(1:length(names), y, custom, 'LineWidth', 2);
if (length(names) > 15)
    %clear bridge names and relabel xticks to [0:100x]
    x_max = length(names) - rem(length(names), 100) + 100;
    xticks(0:100:x_max);
    xtickangle(0);
    xticklabels(0:100:x_max);
    xlim([0 x_max]);
else
    xticks(1:length(names)); 
    xticklabels(names);
    xlim([0, length(names)+1]);
    xtickangle(-45);
end
xlabel('Bridges');
ylabel(ystr);
hold on;
plot(indCircle, y(indCircle), 'or', 'MarkerSize', 15, 'LineWidth', 2);
text(indCircle, y(indCircle), 'Oldest Standing Bridge');
end
