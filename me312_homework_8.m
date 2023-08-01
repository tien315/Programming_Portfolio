close all
clear all
clc

s = tf('s');
kp = [16 64 144 16];
kd = [7 15 23 9];
j = 1; 
b = 1;


for i = 1:length(kp)
   c = kp(i)+kd(i)*s
   p = 1/(j*s^2+b*s)
   t = feedback(c*p,1)
   figure
   hold on
   step(t,2)
   step(t/s)
end
