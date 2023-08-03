%Alan Tieng
%ME428 Numerical Methods
%Final Exam Problem 1

clear all;
close all;
clc;


%% Do not edit this part
% It reads the matrix from the excel file and creates your x and y arrays
a = readmatrix('me428_final_exam1.csv');
x = a(:,1);
y = a(:,2);
%% Write your code for the trapezoidal rule for non-uniform data here


integral = my_trapz(a);


%At the end of your code, you should write out the total value of the
%integral, then copy/paste this solution into your submission document.
disp(integral)
disp(char(java.lang.System.getProperty('user.name'))) % leave this line, proves your work
disp(char(java.net.InetAddress.getLocalHost.getHostName)) % leave this line, proves your work


%This function was modified from a function developed during CS109
%coursework and last used in the final project for this course.

%This function my_trapz calculates the approximation of an integral using
%the trapezoidal method. This function does not assume uniform spacing
%between data points.
%INPUTS
%a - matrix containg data points with the first column containing x values
%    and the second column containing y values.
%OUTPUT
%I - the approximated integral of x with respect to y using the trapezoidal 
%    method.

function I = my_trapz(a)

    I = 0;
    for i = 1:length(a)-1
       I = I + (a(i,2)+a(i+1,2))/2 *(abs(a(i+1,1)-a(i,1))); 
    end

end