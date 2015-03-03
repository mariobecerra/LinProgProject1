% Prueba_Simplex1.m
% Probamos linprog.m con problemas aleatorios
% de la forma
%  Max c'*x
%  A*x =< b
%  x >= 0
%

close all
nc = 100;
M = zeros(nc, 4);
for k = 1:nc
 % generamos el problema
    [c, A, b, m , n ] = Generalinprog;
     n = length(c);
     m = length(b);

    [x,fx, ban, iter] = SIMPLEXFASEII(c, A, b);
    M(k,1) = n;
    M(k,2) = m;
    M(k,3 ) = ban;
    M(k,4) = iter;
end
% Graficaci�n
v = zeros(nc,1);
w = zeros(nc,1);

for k = 1:nc
    v(k) = M(k,1)+M(k,2);
    w(k) = M(k,4);
     if (M(k,3) ==1)
         loglog(v(k),w(k),'bd','LineWidth',3);
         xlabel(' log(n+m)','Fontsize',12)
        ylabel('log(iter) ', 'Fontsize',12)
        title('Estudio Empírico del Simplex  ', 'Fontsize',16)
        hold on
     else
         loglog(v(k),w(k),'sr','LineWidth',3);
         xlabel(' log(n+m)','Fontsize',12)
        ylabel('log(iter) ', 'Fontsize',12)
        title('Estudio Empírico del Simplex  ', 'Fontsize',16)
        hold on
     end
end
    
     
















