%Lab 4 - Loops
%Alan Tieng
%CS 109, Spring 2020, Reckinger

clear all;
close all;
clc;

n = 0;
scores = [];

while true %sentinel loop, break if user input == 999
    user_input = input('Enter a score: ');
    if user_input ~= 999
        n = n + 1;
        scores(n) = user_input;
        continue;
    else
        break;
    end
end

%submit below to zybooks for testing---------------------------------------
%{
grade_categories = {'# of Fs:', '# of Ds:', '# of Cs:', '# of Bs:',...
    '# of As:'};
binned_scores = discretize(scores, [0 60 70 80 90 100], 'categorical',...
    grade_categories);
summary(binned_scores);
%}
%{
ctA = length(scores(scores >= 90 & scores <= 100));
ctB = length(scores(scores >= 80 & scores < 90));
ctC = length(scores(scores >= 70 & scores < 80));
ctD = length(scores(scores >= 60 & scores < 70));
ctF = length(scores(scores < 60));
%}
scores = [90, 93, 75, 51, 66, 88, 85];
n = length(scores);
%{
ctA = 0;
ctB = 0;
ctC = 0;
ctD = 0;
ctF = 0;
%}
[ctA,ctB,ctC,ctD,ctF] = deal(0);

for i = 1:n
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