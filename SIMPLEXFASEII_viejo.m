function [x, fx, ban, iter] = SIMPLEXFASEII (c, A, b)
% Versi�n del Simplex en la fase II.
%Mauricio Vueltiflor Gil 000131077
%Mario Becerra Contreras 000124362
%Jos� Carlos Castro Montes 000127049    
%Aaron L�pez Flores 000124432
% Salida: x valor  optimo del problema, fx valor de la funcion objetivo en x, ban indica los siguientes casos: 
% band = ?1 conjunto factible vac�o, ban == 0 funcion objetivo no acotada superiormente, ban = 1 se encontro solucion �ptima.
% iter es el n�mero de iteraciones (cambios de diccionarios) que hace el m�todo.

%Para que coincidan las dimensiones
[u,v]=size(b);
if(u==1)
    b=b';
end
[u,v]=size(c);
if(u==1)
    c=c';
end

[m,n] = size(A);
A=[A,zeros(m,m)];
A=[zeros(n+m, n) A']';

B=(n+1):(n+m); %B�sicas
N=1:n; %No b�sicas

if(sum(b<0)>0)
    ban=-1;
    disp('Conjunto factible vac�o')
else
    ban=2;
end

fx=0;
b=[zeros(1,n) b']';
c=[c' zeros(1,m)]';
iter=0;
r=sortrows(combvec(1:m+n, 1:m+n)');
while(ban==2 & iter<500)
    iter=iter+1;
    if (sum(c>0) > 0) 
        k=find(c>0,1);
        temp=zeros(m+n,1)+Inf;
        temp(A(:,k)>0)=0;
        temp=temp+(b./A(:,k));
        l=find(temp==min(temp),1); %En caso de empate escoge el de �ndice m�s peque�o
        if(sum(l == 0) | sum(temp)==0 | sum(temp==Inf)==m)   
            ban=0;
            disp('El problema no es acotado');
        else
            fx=fx+c(k)*b(l)/A(l,k); %Actualizar func obj
            c(setdiff(N,k)) = c(setdiff(N,k)) - c(k)*A(l,setdiff(N,k))'/A(l,k); %Act cj pa todo j No b�sica menos k
            c(l)=-c(k)/A(l,k); %Actualizar ck
            b(setdiff(B,l)) = b(setdiff(B,l)) - A(setdiff(B,l),k)*b(l)/A(l,k); %Actualizar bi pa todo i B�sica menos l
            A(setdiff(B, l), setdiff(N,k)) = A(setdiff(B, l), setdiff(N, k)) - (1/A(l,k)) * A(setdiff(B, l),k) * A(l,setdiff(N,k)); %Actualizar aij pa todo j No b�sico menos k y todo i B�sica menos l
            A(setdiff(B, l), l) = - A(setdiff(B, l), k) / A(l,k); %Actualizar ail para todo i B�sica menos l
            b(k) = b(l)/A(l,k); %Actualizar bl
            A(k,setdiff(N,k)) = A(l,setdiff(N,k)) / A(l,k); %Actualizar akj
            A(k,l) = 1/(A(l,k)); %Actualizar akl
            B=union(setdiff(B,l), k);
            N=union(setdiff(N,k), l);
            c(B)=0;
            b(N)=0;
            q=setdiff(r,sortrows(combvec(N,B)'), 'rows');
            for i=1:length(q)
                A(q(i,2),q(i,1))=0;
            end
        end %if
    else
        ban=1;
        disp('Solucion �ptima encontrada');
    end %if
end %while
x=b(1:n);
end