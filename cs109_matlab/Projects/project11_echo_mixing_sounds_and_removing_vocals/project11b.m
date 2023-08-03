for i = 1:100

theta = 0:0.01:2*pi;
rho = sin(2*theta).*cos(2*theta)*i;
polarplot(theta,rho)
drawnow;
rlim([0 50]);
end