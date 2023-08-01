clear all
close all
clc

a = [5 2 7; 8 9 4; 1 1 1];
b = a+1;
c = [1 3; 0 5; 6 2];
d = b' * c;
e = ones(2,3);
[e(:,:)] = deal(-2);
f = d*e;

f(2,1)

size(f)