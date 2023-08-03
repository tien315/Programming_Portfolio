%% Do not edit these lines. This loads your data and calculates matrix size
% Input take home exam matrix
% A = augmented matrix for system of equations
% n = the size of the system of equations
% The matrix is n x n+1, where the n+1 column is the solution vector B.

matrix = load('p1Matrix.mat');
A = matrix.output;
n = length(A)-1; % n is the matrix dimension

%% Your code goes here
% You cannot use any built in matlab functions to solve this problem (no
% RREF, no /, etc...). You must write the Gauss Jordan Elimination method
% yourself.







%% print RHS (You must place your answers in a word or PDF document and
% submit along with the code attached to your submission.
X = A(:,n+1) % this is a sample line that prints the result of the GJ elimination