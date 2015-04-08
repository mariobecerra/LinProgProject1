%Resuelve problemas de Klee-Minty, de dimensiones 3,4,...,10, y reporta los
%resultados en una tabla (USANDO MATLAB R2014A)
%Mauricio Vueltiflor Gil 000131077
%Mario Becerra Contreras 000124362
%José Carlos Castro Montes 000127049    
%Aaron López Flores 000124432
close all
clear all
clc
res=zeros(8,4); %nuestra matriz con los resultados
disp('Resolviendo problemas aleatorios de Klee-Minty:');
for q=1:8
    [c, A, b] = GeneraKleeMinty(q+2); %genera el problema de K-M q+2-dimensional
    tic
    [x,fx,ban,iter]=SIMPLEXFASEII(c,A,b);
    res(q,3)=toc;
    res(q,1)=q+2;
    res(q,2)=iter;
    res(q,4)=2^(q+2);
end
columnas = {'dimension','numiteraciones','tiempo','numvertices'};
%en forma de tabla
T=table(res(:,1),res(:,2),res(:,3),res(:,4),'VariableNames',columnas)
writetable(T)
