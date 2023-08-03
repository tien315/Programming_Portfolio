%%
%Alan Tieng
%ME428 Numerical Methods
%Final Project

%% Instructions
%Run this script by sections only.

%% Analytical Solution
%This section generates a plot of the velocity profile u*, outputs flow 
%rate, and outputs the shear stresses at both walls for the special
%case P = 1 and C = 0 using an analytical method.

close all;
clear all; %#ok<CLALL>
clc;

syms y;
u = @(y) -y.^2+y;
    
fplot(u,[0 1])
xlabel('y*')
ylabel('u*')
title('Fluid Velocity vs. Height in Pipe')

disp("Flow Rate: " + num2str(integral(u,0,1)))
du = eval(['@(y)' char(diff(u(y)))]);

disp("Shear Stress at the top plate: " + num2str(feval(du,1)))
disp("Shear Stress at the bottom plate: " + num2str(feval(du,0)))

%% Numerical Solution
%This section will output a figure comparing the velocity profile u*
%generated via numerical methods when n=5 and n=50. It will also output the
%difference and % error between the n=50 result and the analytical result
%for flow rate, shear stress at the top and shear stress at the bottom.

%n=5, n=50

clear all; %#ok<CLALL>
close all;
clc;

n1 = 5;
n2 = 50;
P = 1;
C = 0;
h = 1;

[flow_n1, Tw_t_n1, Tw_b_n1, u_n1] = plate_flow(n1,P,C,h,false);
[flow_n2, Tw_t_n2, Tw_b_n2, u_n2] = plate_flow(n2,P,C,h,true);
syms y;
u = -y^2+y;

hold on;
plot([0:n1-1]./(n1-1),u_n1); %#ok<NBRAK>
plot([0:n2-1]./(n2-1),u_n2); %#ok<NBRAK>
legend on;
legend("n = " + num2str(n1), "n = " + num2str(n2));
xlabel('y*');
ylabel('u*');
title('Fluid Velocity vs. Height in Pipe');

figure;
hold on;
plot([0:n2-1]./(n2-1),u_n2, 'LineWidth', 2, 'LineStyle', '--') %#ok<NBRAK>
fplot(u,[0 1], 'LineWidth', 1, 'Color', 'r')
legend on;
legend("n = " + num2str(n2), "Exact")
xlabel('y*')
ylabel('u*')
title('Fluid Velocity vs. Height in Pipe')
fprintf('The flow for n = %d is: %10f \n',n1,flow_n1)
fprintf('The flow for n = %d is: %10f \n \n',n2,flow_n2)
fprintf('The top plate shear for n = %d is: %10f \n',n1,Tw_t_n1)
fprintf('The bottom plate shear for n = %d is: %10f \n \n',n2,Tw_b_n1)
fprintf('The top plate shear for n = %d is: %10f \n',n1,Tw_t_n2)
fprintf('The bottom plate shear for n = %d is: %10f \n \n',n2,Tw_b_n2)

disp("The difference between the analytical and numerical results ..." + ...
    "(n="+num2str(n2)+") are:")
disp("Flow difference: " + num2str(abs(1/6-flow_n2)))
disp("Flow error: " + num2str(abs(1/6-flow_n2)/(1/6)) + "%")
disp("Top plate shear difference: " + num2str(abs(-1-Tw_t_n2)))
disp("Top plate shear error: " + num2str(abs(-1-Tw_t_n2)*100) + "%")
disp("Bottom plate shear difference: " + num2str(abs(1-Tw_b_n2)))
disp("Bottom plate shear error: " + num2str(abs(1-Tw_b_n2)*100) + "%")

%% Numerical Solution Varying Step Size
%This section will show the effect of different step sizes. It will print a
%figure showing the numerically calculated flow rate vs the number of data
%points and a figure of the error in flow rate vs the number of data
%points. The maximum number of data points is calculated based on the ee
%(tolerance) which can be changed. When additional data points will no
%longer generate a difference in calculated flows greater than ee, the
%maximum number of data points is set (grid independence at n2 number of
%data points). 
%
%It will also output the difference and % error between the the two for
%flow rate, shear stress at the top, shear stress at the bottom, and the
%number of data points required to achieve this result.

clear all; %#ok<CLALL>
close all;
clc;

n1 = 5;%initial number of points determined by assignment
P = 1;%pressure special case
C = 0;%top plate speed coefficient special case
h = 1;%height
ee = 0.00001;%tolerance

k = n1;
while true
    [flow(k-4), Tw_t(k-4), Tw_b(k-4)] = plate_flow(k,P,C,h,true); %#ok<SAGROW>
    if 1/6-flow(k-4)<ee
        break;
    end
    k = k+1;
end
n2 = k;

hold on;
plot(n1:n2,flow);
fplot(1/6);
axis([n1 n2 0.156 0.168]);
xlabel("Number of Data Points n");
ylabel("Flow Rate V");
title("Flow Rate vs. Number of Data Points");
err = abs(1/6-flow)/(1/6);
legend on;
legend("Numerical Result","Exact Value",'Location',"best")
figure;
plot(n1:n2,err);
xlim([5 inf])
xlabel("Number of Data Points n");
ylabel("% Error");
title("% Error vs. Number of Data Points");

disp("The difference between the analytical and numerical results are:")
disp("Flow difference: " + num2str(abs(1/6-flow(end))))
disp("Flow error: " + num2str(abs(1/6-flow(end))/(1/6)) + "%")
disp("Top plate shear difference: " + num2str(abs(-1-Tw_t(end))))
disp("Top plate shear error: " + num2str(abs(-1-Tw_t(end))*100) + "%")
disp("Bottom plate shear difference: " + num2str(abs(1-Tw_b(end))))
disp("Bottom plate shear error: " + num2str(abs(1-Tw_b(end))*100) + "%")
disp("Number of data points: " + num2str(n2))
disp("Step Size: " + num2str(h/(n2-1)))

%% Numerical Solution Varying P and C
%This section will output 3 diagrams, one showing the effects of varying P*
%for C=0, one one showing the effects of varying P* for C=1 and one showing
%the effects of varying C for n=131. This section also produces 3
%additional subplots showing the effects on flow rate and and shear
%stresses for the three cases above.
%
%This section uses preselected values of P* and C and cannot be changed and
%is only for the purpose of generating specific plots.

clear all; %#ok<CLALL>
close all;
clc;

n = 131;
h = 1;

P = -3:3;
C = 0;
flow_x = 1:length(P);
Tw_t_x = 1:length(P);
Tw_b_x = 1:length(P);
for i = P
    [flow, Tw_t, Tw_b, u] = plate_flow(n,i,C,h,true);
    plot(u,[0:n-1]./(n-1)); %#ok<NBRAK>
    hold on;
    disp("For C=0 and P* = " + num2str(i));
    disp("Flow: " +num2str(flow));
    disp("Shear Stress Top Plate: " +num2str(Tw_t));
    disp("Shear Stress Bottom Plate: " +num2str(Tw_b));
    disp(" ");
    flow_x(i+4) = flow;
    Tw_t_x(i+4) = Tw_t;
    Tw_b_x(i+4) = Tw_b;
end
legend on;
legend("P* = -3","P* = -2","P* = -1","P* = 0","P* = 1","P* = 2","P* = 3",...
    'Location','best')
ylabel('y*')
xlabel('u*')
title('Plate Flow Diagram Showing Effects of Varying P* When C=0')

figure;
subplot(2,2,1)
for i = P
    [flow, Tw_t, Tw_b, u] = plate_flow(n,i,C,h,true);
    plot(u,[0:n-1]./(n-1)); %#ok<NBRAK>
    hold on;
end
legend on;
legend("P* = -3","P* = -2","P* = -1","P* = 0","P* = 1","P* = 2","P* = 3",...
    'Location','best')
ylabel('y*')
xlabel('u*')
title('Plate Flow Diagram Showing Effects of Varying P* When C=0')
subplot(2,2,2)
sgtitle("Effects of Varying P* When C=0")
plot(P,flow_x);
grid on;
title("Flow vs. P*");
xlabel("P*");
ylabel("V*");
subplot(2,2,3)
plot(P,Tw_t_x);
grid on;
title("Top Plate Shear Stress vs. P*");
xlabel("P*");
ylabel("Tw");
subplot(2,2,4)
plot(P,Tw_b_x);
title("Bottom Plate Shear Stress vs. P*");
xlabel("P*");
ylabel("Tw");
grid on;

figure;
P = 1;
C = 0:3;
flow_x = 1:length(C);
Tw_t_x = 1:length(C);
Tw_b_x = 1:length(C);
for i = C
    [flow, Tw_t, Tw_b, u] = plate_flow(n,P,i,h,true);
    plot(u,[0:n-1]./(n-1)); %#ok<NBRAK>
    hold on;
    disp("For P*=1 and C = " + num2str(i));
    disp("Flow: " +num2str(flow));
    disp("Shear Stress Top Plate: " +num2str(Tw_t));
    disp("Shear Stress Bottom Plate: " +num2str(Tw_b));
    disp(" ");
    flow_x(i+1) = flow;
    Tw_t_x(i+1) = Tw_t;
    Tw_b_x(i+1) = Tw_b;
end
legend on;
legend("C = 0","C = 1","C = 2","C = 3",'Location','best')
ylabel('y*')
xlabel('u*')
title('Plate Flow Diagram Showing Effects of Varying C When P*=1')

figure;
subplot(2,2,1)
for i = C
    [flow, Tw_t, Tw_b, u] = plate_flow(n,P,i,h,true);
    plot(u,[0:n-1]./(n-1)); %#ok<NBRAK>
    hold on;
end
legend on;
legend("C = 0","C = 1","C = 2","C = 3",'Location','best')
ylabel('y*')
xlabel('u*')
title('Plate Flow Diagram Showing Effects of Varying C When P*=1')
subplot(2,2,2)
sgtitle("Effects of Varying C When P*=1")
plot(C,flow_x);
grid on;
title("Flow vs. C");
xlabel("C");
ylabel("V*");
subplot(2,2,3)
plot(C,Tw_t_x);
grid on;
title("Top Plate Shear Stress vs. C");
xlabel("C");
ylabel("Tw");
subplot(2,2,4)
plot(C,Tw_b_x);
title("Bottom Plate Shear Stress vs. C");
xlabel("C");
ylabel("Tw");
grid on;

P = -3:3;
C = 1;
figure;
flow_x = 1:length(P);
Tw_t_x = 1:length(P);
Tw_b_x = 1:length(P);
for i = P
    [flow, Tw_t, Tw_b, u] = plate_flow(n,i,C,h,true);
    plot(u,[0:n-1]./(n-1)); %#ok<NBRAK>
    hold on;
    disp("For C=1 and P* = " + num2str(i));
    disp("Flow: " +num2str(flow));
    disp("Shear Stress Top Plate: " +num2str(Tw_t));
    disp("Shear Stress Bottom Plate: " +num2str(Tw_b));
    disp(" ");
    flow_x(i+4) = flow;
    Tw_t_x(i+4) = Tw_t;
    Tw_b_x(i+4) = Tw_b;
end
legend on;
legend("P* = -3","P* = -2","P* = -1","P* = 0","P* = 1","P* = 2","P* = 3",...
    'Location','best')
ylabel('y*')
xlabel('u*')
title('Plate Flow Diagram Showing Effects of Varying P* When C=1')

figure;
subplot(2,2,1)
for i = P
    [flow, Tw_t, Tw_b, u] = plate_flow(n,i,C,h,true);
    plot(u,[0:n-1]./(n-1)); %#ok<NBRAK>
    hold on;
end
legend on;
legend("P* = -3","P* = -2","P* = -1","P* = 0","P* = 1","P* = 2","P* = 3",...
    'Location','best')
ylabel('y*')
xlabel('u*')
title('Plate Flow Diagram Showing Effects of Varying P* When C=1')
subplot(2,2,2)
sgtitle("Effects of Varying P* When C=1")
plot(P,flow_x);
grid on;
title("Flow vs. P*");
xlabel("P*");
ylabel("V*");
subplot(2,2,3)
plot(P,Tw_t_x);
grid on;
title("Top Plate Shear Stress vs. P*");
xlabel("P*");
ylabel("Tw");
subplot(2,2,4)
plot(P,Tw_b_x);
title("Bottom Plate Shear Stress vs. P*");
xlabel("P*");
ylabel("Tw");
grid on;

%% Functions
%This function calculates the flow rate and wall shear stresses at the top
%and bottom plates of fluid flowing between two plates. The formula and 
%boundary conditions used:
%
%                       0 = 2P* + (d^2u*)/(dy*^2)
%                              u*(0)=0
%                              u*(1)=C
%
%INPUTS: 
%n - number of data points
%P - pressure
%C - top plate speed coefficient
%h - height between plates
%supress_print - if true, does not print coefficient matrix a and 
%                 constant vector F
%OUTPUTS:
%V - flow rate
%Tw_top - shear stress at top plate
%Tw_bottom - shear stress at bottom plate
function [V, Tw_top, Tw_bottom, u] = plate_flow(n,P,C,h,suppress_print)
dy = h/(n-1);

A = zeros(n,n);
A(1,1) = 1;
A(n,n) = 1;

%generate coefficient matrix
for i = 2:n-1
   %f_i+1 - 2f_i + f_i-1 = -2P*(dy)^2
   A(i,i+1) = 1;
   A(i,i) = -2;
   A(i,i-1) = 1;
end

%generate constants vector
F = zeros(1,n)';
F(2:end-1,1)=-2*P*dy^2;
F(end,1) = C;


if (suppress_print == false)
    %display a
    disp("coefficient matrix a")
    A %#ok<NOPRT>

    %display c
    disp("RHS matrix F")
    F %#ok<NOPRT>
end

%verify tridiagonal matrix

%%uncomment to test failure-
%a = ones(n,n);
%%--------------------------

is_tridiagonal = 1;
for i = 1:n-2
    for j = i+2:n
        if A(i,j)~=0
            is_tridiagonal = 0;
            break;
        end
    end
    
    if is_tridiagonal == 0
        disp("Coefficient matrix A is not tridiagonal");
        break;
    end
end

%create vectors of coefficients
[a, b, c] = tri_vectorize(A, n);

%thomas algorithm
%disp("u is: ");
u = tdma(a,b,c,F,n);

V = my_trapz(u,dy);
Tw_top = b_diff_T(u,dy);
Tw_bottom = f_diff_T(u,dy);
end


%This function f_diff_T calculates the approximation of a derivative at the 
%beginning of a data set using a forward difference approximation scheme of
%the second order.
%INPUTS
%u - u data points
%dy - step size between data points.
%OUTPUT
%Tw = the approximated derivative
function Tw = f_diff_T(u, dy)

Tw = (-u(3)+4*u(2)-3*u(1))/(2*dy);

end


%This function b_diff_T calculates the approximation of a derivative at the 
%end of a data set using a backward difference approximation scheme of the 
%second order.
%INPUTS
%u - u data points
%dy - step size between data points.
%OUTPUT
%Tw = the approximated derivative
function Tw = b_diff_T(u, dy)

Tw = (3*u(end)-4*u(end-1)+u(end-2))/(2*dy);

end


%This function my_trapz calculates the approximation of an integral using
%the trapezoidal method. This function assumes uniform spacing between stat
%points.
%INPUTS
%u - u data points
%dy - step size between data points.
%OUTPUT
%I - the approximated integral of u with respect to y using
%the trapezoidal method.
function I = my_trapz(u,dy)

    I = 0;
    for i = 1:length(u)-1
       I = I + (u(i)+u(i+1))/2 *dy; 
    end

end


%This function tri_vectorize extracts the coefficients from a tridiagonal 
%matrix and creates 3 vectors.
%INPUTS: 
%A - coefficient matrix
%n - number of unknowns
%OUTPUTS: 
%a - coefficient vector for bottom of tridiagonal
%b - coefficient vector for middle of tridiagonal
%c - coefficient vector for top of tridiagonal
function [a, b, c] = tri_vectorize(A, n)
a = zeros(1,n);
a(1) = 0;
b = zeros(1,n);
c = zeros(1,n);
c(n) = 0;
for i = 1:n-1
    a(i+1) = A(i+1,i);
    c(i) = A(i,i+1);
end

for i = 1:n
    b(i) = A(i,i);
end
end


%This function tdma processes coefficients vectors from a tridiagonal
%matrix and generates a solution vector using the Thomas algorithm. This
%function is taken from page 520 of Jaluria.
%INPUTS: 
%a - coefficient vector for bottom of tridiagonal
%b - coefficient vector for middle of tridiagonal
%c - coefficient vector for top of tridiagonal
%f - constants vector
%n - number of unknowns
%OUTPUTS: 
%t - solution vector
function t = tdma(a, b, c, f, n)
for i = 2:n
    d = a(i)./b(i-1);
    b(i) = b(i)-c(i-1).*d;
    f(i) = f(i)-f(i-1).*d;
end

%
%	 Apply back-substitution
%
t(n) = f(n)./b(n);
for i = 1:n-1
    j = n-i;
    t(j) = (f(j)-c(j).*t(j + 1))./b(j);
end
end