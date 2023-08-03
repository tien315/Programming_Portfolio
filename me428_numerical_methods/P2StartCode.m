%Alan Tieng
%ME428 Numerical Methods
%Midterm Problem 1

clear all;
close all;
clc;

%% This section loads the data, do not edit this part
% This will read the sample data and import it into arrays for you
% y = position data
% t = time data
% n = number points data points
data = load('TimePositionData.mat');
t = data.t';
y = data.y';
n = length(t);
v = zeros([n 1]); % these are initialized as zeros in the beginning to prevent code from spitting errors
a = zeros([n 1]); % these are initialized as zeros in the beginning to prevent code from spitting errors
%% Your code goes here
% calculate v = dy/dt using second-order accuracy
% calculate a = d^2y/dt^2 using second-order accuracy
v(1,1) = (-y(3,1)+4*y(2,1)-3*y(1,1))/(2*(t(2)-t(1)));
a(1,1) = (-y(4,1)+4*y(3,1)-5*y(2,1)+2*y(1,1))/((t(2)-t(1))^2);
for i = 2:n-1
    v(i,1) = (y(i+1,1)-y(i-1,1))/(2*(t(i)-t(i-1)));
    a(i,1) = (y(i+1,1)-2*y(i,1)+y(i-1,1))/((t(i)-t(i-1))^2);
end
v(n,1) = (3*y(n,1)-4*y(n-1,1)+y(n-2,1))/(2*(t(n)-t(n-1)));
a(n,1) = (2*y(n,1)-5*y(n-1,1)+4*y(n-2,1)-y(n-3,1))/((t(n)-t(n-1))^2);




%% This section of code makes all the plots/data required for submission
% You may need to change the variable names if you named your variables
% differently in your code.
figure(1); % This makes the first figure of plots
subplot(3,1,1);
plot(t,y); % this is the time/position plot
xlabel('t');
ylabel('y');
ylim([min(y)-0.1 max(y)+0.1])
xlim([min(t) max(t)])
title('Position')
subplot(3,1,2);
plot(t,v); % this is the time velocity plot
xlabel('t');
ylabel('v');
ylim([min(v)-0.5 max(v)+0.5])
xlim([min(t) max(t)])
title('Velocity')
subplot(3,1,3);
plot(t,a); % this is the time acceleration plot
xlabel('t');
ylabel('a');
title('Acceleration')
xlim([min(t) max(t)])
ylim([min(a)-0.05 max(a)+0.05]) % scales the plot so its not messy
figure(2); % this generates a table of the resulting data for checking
T = table(t,y,v,a);
uitable('Data',T{:,:},'ColumnName',T.Properties.VariableNames,'Units', 'Normalized', 'Position',[0, 0, 1, 1]);