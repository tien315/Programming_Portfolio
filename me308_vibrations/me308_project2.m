%defining variables
syms x(t) %x as symfun and t as sym
m=2.5*10^-6; %mass
c=0; %damping
k=7*10^7; %spring constant
F0=1; %amplitude
wf=5.2*10^6; %angular freq
phi=0; %phase
t1=0; %lower limit of integration
t2=10; %upper limit of integration
x0=0; %initial condition position
v0=0; %initial condition velocity
y0=[x0 v0]; %IC vector for ode45
w = sqrt(k/m);

dx=diff(x,t) %symfun for first derivative of x
eq1=diff(x,2) == F0/(k-m*wf^2)*sin(wf*t+phi) + (F0*wf)/(k-m*wf^2)*sin(5291502.622*t) %defining the equation 
                                                 %2nd derivative of x
vars=[x(t)]
[V]=odeToVectorField([eq1]) %reduce to first order diffeq
M=matlabFunction(V,'vars', {'t','Y'}) %convert the symbolic function V into a
                                      %function with the handle 'm'
interval=[t1 t2]; %tspan for ode45
sol=ode45(M,interval,y0)
%fplot(@(x)deval(sol,x,1),interval) %plot the graph @x, solved equation using deval
fplot(eq1,interval)