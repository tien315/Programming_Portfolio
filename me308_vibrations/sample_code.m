syms x(t)
m=0.05;
c=0;
g=9.81;
wf=2; %some random value here (it is 2 for SSLQ8)
Y0=0.01;
L=0.44;
F0=m.*wf^2.*Y0.*0.5.*L;
I=1/12.*m.*L^2;
me=I+0.25.*m.*L^2;
ke=0.5.*m.*g.*L;
ce=c;
phi=0;
t1=0;
t2=20;
x0=0;
v0=0;
y0=[x0 v0];
dx=diff(x,t);
eq1=diff(x,2) == F0/me*sin(wf*t+phi) -ce/me*dx -ke/me*x;
vars=[x(t)]
[V]=odeToVectorField([eq1])
M=matlabFunction(V,'vars', {'t','Y'})
interval=[t1 t2];
sol=ode45(M,interval,y0);
fplot(@(x)deval(sol,x,1),interval)