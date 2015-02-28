% Prueba_Simplex_KleeMinty.m
% Probamos linprog.m con Klee-Minty
%

close all
nc = 4;
M = zeros(nc, 43);
tic
for k = 1:nc
 % generamos el problema
    [c, A, b] = GeneraKleeMinty(10);
    [x,fx,ban,iter]=SIMPLEXFASEII(c,A,b);
    k
    fx
    iter
end
toc