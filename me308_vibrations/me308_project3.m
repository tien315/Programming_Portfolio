%defining variables
syms x(t) %x as symfun and t as sym
m=0.018857433; %mass kg
c=0.005290042; %damping
k=194.1480644; %spring constant
F0=0.02; %amplitude
wf=102.2348796; %angular freq
phi=-1.570796316; %phase
t1=0; %lower limit of integration
t2=1; %upper limit of integration
x0=-0.02; %initial condition position
v0=0; %initial condition velocity
y0=[x0 v0]; %IC vector for ode45


dx=diff(x,t) %symfun for first derivative of x
eq1=diff(x,2) == F0*cos(wf*t+phi) -c/m*dx -k/m*x%defining the equation 
                                                 %2nd derivative of x
vars=[x(t)]
[V]=odeToVectorField([eq1]) %reduce to first order diffeq
M=matlabFunction(V,'vars', {'t','Y'}) %convert the symbolic function V into a
                                      %function with the handle 'm'
interval=[t1 t2]; %tspan for ode45
sol=ode45(M,interval,y0)
fplot(@(x)deval(sol,x,1),interval) %plot the graph @x, solved equation using deval
