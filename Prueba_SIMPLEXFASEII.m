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
    [c, A, b] = GeneraKleeMinty(q);
    %Método de MATLAB
    n = length(c);
    m = length(b);
    lb = zeros(n,1);
    ub = inf*ones(n,1);
    options=optimset('Algorithm','interior-point-convex');
    [x_m,fx_m exitflag, output_m ] =linprog(-c,A,b,[],[],lb,ub,[],options);
    %MiSIMPLEX
    [x,fx,ban,iter]=SIMPLEXFASEII(c,A,b);
    disp('Prueba KM numero')
    q
    fx_m
    fx
    iter
end
toc

%Generalp
tic
glp=500;
yo=zeros(glp,1);
mat=yo;
disp('Empezando LinProg')
for r = 1:glp
    [c, A, b] = Generalp;
    %Método de MATLAB
    n = length(c);
    m = length(b);
    lb = zeros(n,1);
    ub = inf*ones(n,1);
    options=optimset('Algorithm','interior-point-convex');
    [x_m,fx_m exitflag, output_m ] =linprog(-c,A,b,[],[],lb,ub,[],options);
    %Mi método
    [x,fx,ban,iter]=SIMPLEXFASEII(c,A,b);
    fx_m=-fx_m;
    if(ban==1 | exitflag==1)
        yo(r)=fx;
        mat(r)=fx_m;
        fx
        fx_m
        fx_m-fx
    end
end
toc
toc