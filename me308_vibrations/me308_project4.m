close all
clear all
clc

global wf
global k
global m
global c
global F0;
global phi;
global w;

F0=1; %amplitude of forcing
phi=0; %phase
t = linspace(0,0.00001);   % time scale
k=7*10^7; %spring constant in N/m
m = 2.5*10^-6; %mass in kg
w = sqrt(k/m); %natural freq in rad/s
%wf = .1*w; %forcing freq in rad/s
c=0; %damping in Nms

x0=0; %initial condition position
v0=0; %initial condition velocity
y0=[x0 v0]; %IC vector for ode45

h = figure;
axis tight manual % this ensures that getframe() returns a consistent size
filename = 'harmonic_project4.gif';

for i = 0.000:0.005:1.000
    wf = i*w;
    r = wf/w;
    [t,x]=ode45( @glass, t, y0 );
    plot(t,x(:,1), 'LineWidth', 2);
    xlabel('t'); 
    ylabel('x');
    title('r=',sprintf('%.3f', r));
    set(gca,'Color','k')
    xlim([0 0.00001]);
    ylim([-10^-7 10^-7]);
    text(0,.9*10^-7,'Alan Tieng', 'Color','r')
    drawnow
    frame = getframe(h); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 
    % Write to the GIF File 
    if i == 0.000
      imwrite(imind,cm,filename,'gif','Loopcount',inf); 
    else 
      imwrite(imind,cm,filename,'gif','DelayTime',1/30,'WriteMode','append'); 
    end
end

imshow('explosion.jpg')
drawnow;
frame = getframe(h); 
im = frame2im(frame); 
[imind,cm] = rgb2ind(im,256); 
imwrite(imind,cm,filename,'gif','WriteMode','append');

    
    
    function xdot=glass(t,x)
    
    global k;
    global m;
    global wf;
    global c;
    global F0;
    
    dx = x(2);
    dxdt2 = -c/m*dx - k/m*x(1) + F0/m*cos(wf*t);

    xdot=[dx; dxdt2];
    end