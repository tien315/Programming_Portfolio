%Project 4 - Loops and Temps
%Alan Tieng
%CS 109, Spring 2020, Reckinger

clear all;
close all;
clc;

%Part 1--------------------------------------------------------------------
n = 0;
while true %sentinel loop, break if user input == -99
    user_input = input('Enter a temperature in Fahrenheit: ');
    if user_input ~= -99
        n = n + 1;
        temps(n) = user_input;
        continue;
    else
        break; 
    end
end

%Part 2--------------------------------------------------------------------
subplot(2,1,1);
plot(temps(1:n) , 'o:r', 'LineWidth', 1);
xlabel("Day");
ylabel("Temperature in Fahrenheit");
title("Temperatures");
xticks(1:n);

%Part 3--------------------------------------------------------------------
%loop through temps and tally each category.  # of cold, comfortable, and
%hot days
comfort_categories = categorical({'# of Cold Days',...
    '# of Comfortable Days', '# of Hot Days'});
temp_comfort = [0,0,0]; %[cold,comfort,hot]
for i = 1:n 
    if temps(i) <= 32
        temp_comfort(1) = temp_comfort(1) + 1;
    elseif temps(i) >= 70
        temp_comfort(3) = temp_comfort(3) + 1;
    else
        temp_comfort(2) = temp_comfort(2) + 1;
    end
end
subplot(2,1,2);
bar(comfort_categories,temp_comfort)