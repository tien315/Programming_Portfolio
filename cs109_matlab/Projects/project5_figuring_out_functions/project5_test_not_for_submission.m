clear all;
close all;
clc;

namesSmall = ["CENTRAL OVER S&S CAN","WACKER-MICHIGAN-RAND","RYAN SB RMP TO 55WB","1.3-2.6 MI SW OF I94","MICH.AVE-S.OF RIVER", "North to West Ramp","RIVER TO CANAL ST","RAMP 'G'","RANDOLPH-MICHIGAN-FI","55 EB RMP TO SB RYAN","LARAMIE    K2 AVE BR", "CANAL-HARRISON-TAYLO", "CANAL-MADISON-ADAMS"];
yearBuiltSmall = [1970,1926,1962,1963,1921,2015,1962,2006,1937,1964,1956,1926,1926];
yearReconstructSmall = [2007,2002,1990,2000,1998,0,1989,0,1981,1997,1999,1983,1983];
scoreSmall = [79,50,94.5,94,60.9,96,68,96,80.9,94.4,80.2,41.4,45.6];

%plotIt(yearBuiltSmall, "Year Built", 'rv', namesSmall, 9)
plotIt(yearReconstructSmall, "Year Reconstructed", 'bo', namesSmall, 9)
% plotIt(scoreSmall, "Overall Score", 'g*', namesSmall, 9)

function plotIt(y, ystr, custom, names, indCircle)
y(y==0) = NaN;
plot(1:length(names), y, custom);

xticks(1:length(names)); 
xticklabels(names);
xlim([0, length(names)+1]);
xlabel('Bridges')
xtickangle(-45);
yticks(min(y) - rem(min(y),10):10:max(y) - rem(max(y),10) + 10);
ylabel(ystr);

hold on;
plot(indCircle, y(indCircle), 'or', 'MarkerSize', 20);
text(indCircle, y(indCircle), 'Oldest Standing Bridge');
end