nel = 1.875;
h = 0.0021; %m
L = 0.163; %m
E = 6.6*10^10; %pa
rho = 2600; %kg/m^3

f1 = nel^2*h/(2*pi)
f2 = sqrt(E/(12*rho*L^4))

f = f1*f2
