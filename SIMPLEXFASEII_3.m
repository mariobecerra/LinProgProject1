function [x, fx, ban, iter] = SIMPLEXFASEII_3 (c, A, b)
% Versión del Simplex en la fase II.
% Salida: x valor  optimo del problema, fx valor de la funcion objetivo en x, ban indica los siguientes casos: 
% band = −1 conjunto factible vacío, ban == 0 funcion objetivo no acotada superiormente, ban = 1 se encontro solucion óptima.
% iter es el número de iteraciones (cambios de diccionarios) que hace el método.

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

B=(n+1):(n+m); %Básicas
N=1:n; %No básicas

if(sum(b<0)>0)
    ban=-1;
    disp('Conjunto factible vacío')
else
    ban=2;
end

fx=0;
b=[zeros(1,n) b']';
c=[c' zeros(1,m)]';
iter=0;
r=sortrows(combvec(1:m+n, 1:m+n)');
while(ban==2 & iter<5000)
    iter=iter+1;
    if (sum(c>0) > 0) 
        k=find(c>0,1);
        temp=zeros(m+n,1)+Inf;
        temp(A(:,k)>0)=0;
        temp=temp+(b./A(:,k));
        l=find(temp==min(temp),1); %En caso de empate escoge el de índice más pequeño
        if(sum(l == 0) | sum(temp)==0 | sum(temp==Inf)==m)   
            ban=0;
            disp('El problema no es acotado');
        else
            fx=fx+c(k)*b(l)/A(l,k); %Actualizar func obj
            temp1=dif(N,k); temp2=dif(B, l);
            c(temp1) = c(temp1) - c(k)*A(l,temp1)'/A(l,k); %Act cj pa todo j No básica menos k
            c(l)=-c(k)/A(l,k); %Actualizar ck
            b(temp2) = b(temp2) - A(temp2,k)*b(l)/A(l,k); %Actualizar bi pa todo i Básica menos l
            
            A(temp2, temp1) = A(temp2, temp1) - (1/A(l,k)) * A(temp2,k) * A(l,temp1); %Actualizar aij pa todo j No básico menos k y todo i Básica menos l
            A(temp2, l) = - A(temp2, k) / A(l,k); %Actualizar ail para todo i Básica menos l
            b(k) = b(l)/A(l,k); %Actualizar bl
            A(k,temp1) = A(l,temp1) / A(l,k); %Actualizar akj
            A(k,l) = 1/(A(l,k)); %Actualizar akl
            B=union(temp2, k);
            N=union(temp1, l);
            c(B)=0;
            b(N)=0;
            q=dif_mat(r,sortrows(combvec(N,B)'));
            for i=1:length(q)
                A(q(i,2),q(i,1))=0;
            end
        end %if
    else
        ban=1;
        disp('Solucion óptima encontrada');
    end %if
end %while
x=b(1:n);
end