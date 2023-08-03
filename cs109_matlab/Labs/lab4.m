%Lab 4 - Loops
%Alan Tieng
%CS 109, Spring 2020, Reckinger

clear all;
close all;
clc;

%submit below to zybooks for testing---------------------------------------
[ctA,ctB,ctC,ctD,ctF] = deal(0); %initialize ctX to 0

for i = 1:n %loop through scores and tally grades
    if (scores(i)<60)
        ctF = ctF + 1;
    elseif ((scores(i) < 70) && (scores(i) >= 60))
        ctD = ctD + 1;
    elseif ((scores(i) < 80) && (scores(i) >= 70))
        ctC = ctC + 1;
    elseif ((scores(i) < 90) && (scores(i) >= 80))
        ctB = ctB + 1;
    else
        ctA = ctA + 1;
    end
end

disp("# of As:" + ctA);
disp("# of Bs:" + ctB);
disp("# of Cs:" + ctC);
disp("# of Ds:" + ctD);
disp("# of Fs:" + ctF);