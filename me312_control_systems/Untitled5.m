os =10;
ts = 1;
tp = 1.1222
zai = .707
wn = pi/(tp*sqrt(1-zai^2));

xnew = -zai*wn;
ynew = zai*wn*tand(acosd(.707));


theta1 = 180+atand((ynew)/(xnew-1));
theta2 = atand((ynew)/(3+xnew));
theta3 = theta1+theta2-180;
theta5 = 180+atand(ynew/(xnew+.5));
z = (wn*sqrt(1-zai^2))/tand(theta3)+wn*zai;

L1 = (-xnew-1)/cosd(180-theta1);
L2 = (3+xnew)/cosd(theta2);
L4 = sqrt(xnew^2+ynew^2);

L3 = (z+xnew)/cosd(theta3);
L5 = (-xnew-1)/cosd(180-theta1);

k = L1*L2*L4/L3/L5;

s = tf('s');
k=1.9;
c = k*(s+z)*(s+0.5)/s;

g = 1/((s-1)*(s+3));

T = feedback(c*g,1);
stepinfo(T)