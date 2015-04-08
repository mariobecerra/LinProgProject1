function [c, A, b] = Generalp(m,n)
% Genera problemas aleatorios de Programaci�n Lineal del tipo
%  Max c'*x
%  A*x =< b
%  x >= 0
%
% Out
% c es un vector n-dimensional
% b es un vector m- idimensional tal que b >= 0.
% m < n
% A es una matriz real de mxn

 
sigma = 10;
A = round(sigma*randn(m,n));             % matriz de restricciones
b = round(sigma*abs(randn(m,1) ) );      % lado derecho
c = round(sigma*randn(n,1));             % vector de funci�n objetivo



end

