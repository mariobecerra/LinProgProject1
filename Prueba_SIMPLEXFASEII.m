% Prueba_SIMPLEXFASEII.m
% Probamos SIMPLEXFASEII.m con Klee-Minty y con Generalp.m
tic
%Klee-Minty
close all
km = 10;
M = zeros(km, 43);
tic
disp('Empezando Klee Minty')
for q = 3:km
 % generamos el problema
    [c, A, b] = GeneraKleeMinty(q);
    [x,fx,ban,iter]=SIMPLEXFASEII(c,A,b);
    disp('Prueba KM numero')
    q
    fx
    iter
end
toc

%Generalp
tic
glp=3;
disp('Empezando LinProg')
for r = 1:glp
 % generamos el problema
    [c, A, b] = Generalp;
    [x,fx,ban,iter]=SIMPLEXFASEII(c,A,b);
    disp('Prueba LP numero')
    r
    fx
    iter
end
toc
toc