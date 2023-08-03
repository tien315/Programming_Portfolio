%Project 4 - Loops and Temps
%Alan Tieng
%CS 109, Spring 2020, Reckinger

clear all;
close all;
clc;

%{
%Part 1--------------------------------------------------------------------
n = 0;
while true %sentinel loop, break if user input == -99
    user_input = input('Give me a temperature in Fahrenheit: ');
    if user_input ~= -99
        n = n + 1;
        temps(n) = user_input;
        continue;
    else
        break;
    end
end
%}
temps = randi([-20, 100], [1, 20]); %test, comment out when done

%Part 2--------------------------------------------------------------------
subplot(2,1,1);
%plot(temps(1:n) , 'o:r', 'LineWidth', 1);
plot(temps(1:length(temps)) , 'o:r', 'LineWidth', 1); %test, comment out when done
xlabel("Day");
ylabel("Temperature in Fahrenheit");
title("Temperatures");
%xticks(1:n);

%Part 3--------------------------------------------------------------------
%loop through temps and tally each category.  # of cold, comfortable, and
%hot days
comfort_categories = categorical({'# of Cold Days',...
    '# of Comfortable Days', '# of Hot Days'});
binned_temp_comfort = discretize(temps,[-inf 33 71 inf], 'categorical',...
    {'# of Cold Days', '# of Comfortable Days', '# of Hot Days'});
temp_comfort = [0,0,0]; %[cold,comfort,hot]
%{
for i = 1:n 
    if temps(i) <= 32
        temp_comfort(1) = temp_comfort(1) + 1;
    elseif temps(i) >= 70
        temp_comfort(3) = temp_comfort(3) + 1;
    else
        temp_comfort(2) = temp_comfort(2) + 1;
    end
end
%}
subplot(2,1,2);
bar(comfort_categories, temp_comfort)