clc

%Part 1
r = 5.0;
c = (32440 / r) + (425 * pi * r);
disp(c);

%Part 2
LB = 6.0;
RB = 1.5;
RS = 3.0;
volume = (pi * (RB^2) * LB) + 2 * ((4 / 3) * pi * (RS^3));
% fprintf("The volume of the barbell is: %d in^3 \n", volume);
%{
x = ['The volume of the barbell is: ', num2str(volume) , 'in^3'];
disp(x);
%}
disp("The volume of the barbell is: " + volume + "in^3")