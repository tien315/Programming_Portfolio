clear all
close all
clc

%variables for motor EC90-------------------------------------------------- 
% t_stall = 7.480; %N*m
% omega_NL = 3120*2*pi/60; %rad/s
% e_a = 36; %V
% j_armature = 0.00306; %kg*m^2
% d_armature = 0; %(N*m*s)/rad
%--------------------------------------------------------------------------

%variables for motor EC90 kollmorgen------------------------------------------------
t_stall = 13.1; %N*m
omega_NL = 1960*2*pi/60; %rad/s
e_a = 48; %V
j_armature = 0.000506; %kg*m^2
d_armature = 0.0002069; %(N*m*s)/rad1
%--------------------------------------------------------------------------



d_load = 6; %(N*m*s)/rad
arm_len = 1; %meters
arm_dia = 0.05; %m
mass_b = 1; %kg mass of ball
mass_a = 1; %kg mass of arm
mass_b_dia = 0.1; %m
n1 = 1;
n2 = 20;
g = 10; %m/s^2

%calculate inertia of arm with mass
j_load = (1/4) * mass_a * (arm_dia/2)^2 +...
         (1/12) * mass_a * arm_len^2 +...
         mass_a * (arm_len/2)^2 +...
         (2/5) * mass_b * (mass_b_dia/2)^2 +...
         mass_b * (arm_len + mass_b_dia/2)^2;

%for point mass m only
%j_load = mass_b*arm_len^2;

%total inertia of system
j_m = j_armature + (n1/n2)^2*j_load;

%total damping of system
d_m = d_armature + (n1/n2)^2*d_load;

kt_ra = t_stall/e_a;
kb = e_a/omega_NL;

kt = .321;
ra = .844;
kb = 1.3; %1.3

%test for arm with mass
% p_center_mass = ((mass_b + mass_a)/2)/(mass_a/arm_len);
% G_m = tf([kt_ra/j_m],[1 (d_m+kt_ra*kb)/j_m ...
%     (1/j_m)*(mass_b+mass_a)*g*p_center_mass])
% G_l = tf([kt_ra/j_m*(n1/n2)],[1 (d_m+kt_ra*kb)/j_m ...
%     (1/j_m)*(mass_b+mass_a)*g*p_center_mass])

%taken direct from sheet
% p_center_mass = ((mass_b + mass_a)/2)/(mass_a/arm_len);
% G_m = tf([kt/ra/j_m],[1 (d_m+kt/ra*kb)/j_m ...
%     (1/j_m)*(mass_b+mass_a)*g*p_center_mass])
% G_l = tf([kt/ra/j_m*(n1/n2)],[1 (d_m+kt/ra*kb)/j_m ...
%     (1/j_m)*(mass_b+mass_a)*g*p_center_mass])

%point mass m and massless arm
G_m = tf([kt_ra/j_m],[1 (d_m+kt_ra*kb)/j_m ...
    kt_ra/j_m*mass_b*g*arm_len])
G_l = tf([kt_ra/j_m*(n1/n2)],[1 (d_m+kt_ra*kb)/j_m ...
    kt_ra/j_m*(mass_b)*g*arm_len])

hold on
legend

step(G_m)
step(G_l)
