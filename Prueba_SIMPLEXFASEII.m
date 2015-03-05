% Prueba_SIMPLEXFASEII.m
% Probamos SIMPLEXFASEII.m con Klee-Minty y con Generalp.m
% %Klee-Minty
% close all
% km = 10;
% M = zeros(km, 43);
% disp('Empezando Klee Minty');
% fid=fopen('./Out/Resultados Klee-Minty.txt', 'w');
% fprintf(fid, 'q,fx,ban,iter, tiempo\n');
% for q = 3:km
%     [c, A, b] = GeneraKleeMinty(q);
%     tic;
%     [x,fx,ban,iter]=SIMPLEXFASEII(c,A,b);
%     t=toc;
%     fprintf(fid, '%d, %f, %d, %d, %f\n', q,fx,ban,iter, t);
% end
% fclose(fid);

% %Generalp
close all
nc = 1000;
M = zeros(nc, 4);
fid=fopen('./Out/Resultados Generalp.txt', 'w');
fprintf(fid, 'q,m,n,fx,ban,iter, tiempo\n');
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
  