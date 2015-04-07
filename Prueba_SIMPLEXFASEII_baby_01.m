% Prueba_SIMPLEXFASEII_baby_01.m
% Probamos SIMPLEXFASEII.m con Klee-Minty y con Generalp.m
%Klee-Minty
close all
km = 10;
km=4;
M = zeros(km, 43);
disp('Empezando Klee Minty');
fid=fopen('./Out/Resultados Klee-Minty.txt', 'w');
fprintf(fid, 'q,fx,ban,iter\n');
for q = 3:km
    [c, A, b] = GeneraKleeMinty(q);
    [x,fx,ban,iter]=SIMPLEXFASEII(c,A,b);
    fprintf(fid, '%d, %f, %d, %d\n', q,fx,ban,iter);
end
fclose(fid);

% %Generalp
close all
nc = 1;
M = zeros(nc, 4);
fid=fopen('./Out/Resultados Generalp.txt', 'w');
fprintf(fid, 'q,m,n,fxMi,banMi,iterMi,fxMAT,banMAT\n');
for k = 1:nc
    nc
    [c, A, b] = Generalp;
     n = length(c)
     m = length(b)
    %Método de MATLAB
    n = length(c);
    m = length(b);
    lb = zeros(n,1);
    ub = inf*ones(n,1);
    options=optimset('Algorithm','interior-point-convex');
    [x_m,fx_m exitflag, output_m ] =linprog(-c,A,b,[],[],lb,ub,[],options);
    %Mimétodo
    [x,fx, ban, iter] = SIMPLEXFASEII(c, A, b);
    fprintf(fid, '%d, %d,%d, %f, %d, %d, %f, %d\n', k,m,n,fx,ban,iter, fx_m, exitflag);
    M(k,1) = n;
    M(k,2) = m;
    M(k,3 ) = ban;
    M(k,4) = iter;
    if(ban==1)
        ban
        fx_m
        fx
    end
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
