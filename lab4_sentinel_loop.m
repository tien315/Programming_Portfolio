%Lab 4 - Loops (Sentinel Loop)
%Alan Tieng
%CS 109, Spring 2020, Reckinger

clear all;
close all;
clc;

n = 0;
scores = [];

while true %sentinel loop, break if user input == 999
    user_input = input('Enter a score (Enter 999 to STOP): ');
    if user_input ~= 999
        n = n + 1;
        scores(n) = user_input;
        continue;
    else
        break;
    end
end