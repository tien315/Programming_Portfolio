clear all
close all
clc


%variables for motor EC90 kollmorgen---------------------------------------
t_stall = 13.1; %N*m
omega_NL = 1960*2*pi/60; %rad/s
e_a = 48; %V
j_armature = 0.000506; %kg*m^2
d_armature = 0.0002069; %(N*m*s)/rad
kt = .231;
ra = .844;
kb = 1.31;
%--------------------------------------------------------------------------

d_load = 6; %(N*m*s)/rad
arm_len = 1; %meters
mass_b = 1; %kg mass of ball
n1 = 1;
n2 = 10;
g = 10; %m/s^2


j_load = mass_b*arm_len^2;

%total inertia of system
j_m = j_armature + (n1/n2)^2*j_load;

%total damping of system
d_m = d_armature + (n1/n2)^2*d_load;

 %1.3

%point mass m and massless arm
Gm = tf([(kt/ra)*(1/j_m)],[1 (d_m+(kt/ra)*kb)*(1/j_m) ...
    (1/j_m)*(mass_b)*g*arm_len])
Gl = tf([(kt/ra)*(1/j_m)*(n1/n2)],[1 (d_m+(kt/ra)*kb)*(1/j_m) ...
    (1/j_m)*(mass_b)*g*arm_len])
s = tf('s');


legend
c = tf(127/s);
Gs = feedback(Gl,1);
nod = stepinfo(Gs)
hold on
ClosedLoop = Gl
OpenLoop = feedback(Gl,1)
%step(OpenLoop)
step(ClosedLoop)


% time_s = [];
% k = [];
% timeset = [];
% for i = 0:0.1:10  
% c = tf(i/s);
% k = [k,i];
% Gs = feedback(c*Gm,1);
% nod = stepinfo(Gs);
% time_s = [time_s, nod.SettlingTime];
% end
% plot(k,time_s)

%step(Gs)
% step(Gm)
% step(Gl)


