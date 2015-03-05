% Prueba_SIMPLEXFASEII.m
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
fprintf(fid, 'q,m,n,fx,ban,iter\n');
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
    fprintf(fid, '%d, %d,%d, %f, %d, %d\n', k,m,n,fx,ban,iter);
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