function [c, A, b] = Generalp

%Mauricio Vueltiflor Gil 000131077
%Mario Becerra Contreras 000124362
%José Carlos Castro Montes 000127049    
%Aaron López Flores 000124432
% Genera problemas aleatorios de Programaci?n Lineal del tipo
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

m = round( 10*exp( log(100)*rand()) );  % n?mero de restricciones
n = round( 10*exp( log(100)*rand()) );  % n?mero de variables

if(m==0 | m==1)
m=2;
end

if(m>n)
    m1=n;
    n=m;
    m=m1;
end

sigma = 10;
A = round(sigma*randn(m,n));             % matriz de restricciones
b = round(sigma*abs(randn(m,1) ) );      % lado derecho
c = round(sigma*randn(n,1));             % vector de funci?n objetivo


end