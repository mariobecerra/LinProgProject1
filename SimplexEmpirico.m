% SimplexEmpirico.m
% Probamos SIMPLEXFASEII.m con Generalp.m
%Mauricio Vueltiflor Gil 000131077
%Mario Becerra Contreras 000124362
%José Carlos Castro Montes 000127049    
%Aaron López Flores 000124432
% Generalp
close all
nc = 10;
M = zeros(nc, 4);
fid=fopen('./Out/Resultados Generalp.txt', 'w');
fprintf(fid, 'q,m,n,fx,ban,iter, tiempo\r\n');
for k = 1:nc
    k
    [c, A, b] = Generalp;
     n = length(c);
     m = length(b);
     tic
    [x,fx, ban, iter] = SIMPLEXFASEII(c, A, b);
    t=toc;
    fprintf(fid, '%d, %d,%d, %f, %d, %d, %f\n', k,m,n,fx,ban,iter, t);
    M(k,1) = n;
    M(k,2) = m;
    M(k,3 ) = ban;
    M(k,4) = iter;
end
fclose(fid);
% Gráficas
v = zeros(nc,1);
w = zeros(nc,1);
h=figure;
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
saveas(h,'./Out/Graf', 'jpg') 