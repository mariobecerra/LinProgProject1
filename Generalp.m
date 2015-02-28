function [c, A, b] = Generalp
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
%-------------------------------------------------
% Detalles en: Robert J. Vanderbei, Linear Programming, Foundations
%  and Extension, Fourth Edition, Springer, New York, 2014, pags:44-50
%
%rng(124365);

 %m = round( 10*exp( log(100)*rand()) );  % n�mero de restricciones
 %n = round( 10*exp( log(100)*rand()) );  % n�mero de variables
 
  m = round( 2/10*exp( log(100)*rand()) );  % n�mero de restricciones
  n = round( 2/10*exp( log(100)*rand()) );  % n�mero de variables
% 
sigma = 10;
A = round(sigma*randn(m,n));             % matriz de restricciones
b = round(sigma*abs(randn(m,1) ) );      % lado derecho
c = round(sigma*randn(n,1));             % vector de funci�n objetivo



end

