clear all;
close all;
clc;



syms y
syms u
p = 1
c = 0

u = @(y) -p*y.^2+(c+p).*y;

fplot(u,[0 1])