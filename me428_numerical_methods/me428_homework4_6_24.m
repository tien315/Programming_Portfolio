clear all;
close all;
clc;

a = [  4 -1  0 -1  0  0  0  0  0 90;
      -1  4 -1  0 -1  0  0  0  0 40;
       0 -1  4  0  0 -1  0  0  0 60;
      -1  0  0  4 -1  0 -1  0  0 50;
       0 -1  0 -1  4 -1  0 -1  0  0;
       0  0 -1  0 -1  4  0  0 -1 20;
       0  0  0 -1  0  0  4 -1  0 150;
       0  0  0  0 -1  0 -1  4 -1 100;
       0  0  0  0  0 -1  0 -1  4 140;]
   
rref(a)