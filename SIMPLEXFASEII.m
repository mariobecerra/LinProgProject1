function [x, fx, ban, iter] = SIMPLEXFASEII (c, A, b)
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
x=zeros(m+n,1);
A=[A,eye(m,m)];
B=(n+1):(n+m);
N=1:n;
fx=0;
iter=0;
ban=2;
while(ban==2 & iter<5000)
    iter=iter+1;
    if (sum(c>0) > 0) 
        k=min(find(c>0));
        temp=zeros(m,1)+Inf;
        temp(b./A(:,k)>0)=0;
        temp=temp+(b./A(:,k));
        l=min(find(temp==min(temp))); %En caso de empate escoge el de índice más pequeño
        if(sum(l == 0) | sum(temp)==0 | sum(temp==Inf)==m)   
            ban=0;
            disp('El problema no es acotado');
            break;
        else
            x(l)=b(l);
            x(l)=b(k)/A(l,k);
            fx=fx+c(k)*b(l)/A(l,k); %Actualizar func obj
            if(sum(c([1:k-1 k+1:n])>0))
                c([1:k-1 k+1:n]) = c([1:k-1 k+1:n]) - c(k)*A(l,[1:k-1 k+1:n])'/A(l,k); %Act cj pa todo j No básica menos k
            end
            c(k)=-c(k)/A(l,k); %Actualizar ck
            if(sum(b([1:l-1 l+1:m]))==0)
                b([1:l-1 l+1:m]) = b([1:l-1 l+1:m]) - A([1:l-1 l+1:m],k)'*b(l)/A(l,k); %Actualizar bi pa todo i Básica menos l
            else
                b([1:l-1 l+1:m]) = b([1:l-1 l+1:m]) - A([1:l-1 l+1:m],k)*b(l)/A(l,k);
            end
            A([1:l-1 l+1:m], [1:k-1 k+1:n]) = A([1:l-1 l+1:m], [1:k-1 k+1:n]) - (1/A(l,k)) * A([1:l-1 l+1:m],k) * A(l,[1:k-1 k+1:n]); %Actualizar aij pa todo j No básico menos k y todo i Básica menos l
            A([1:l-1 l+1:m], l) = A([1:l-1 l+1:m], k) / A(l,k); %Actualizar ail para todo i Básica menos l
            b(l) = b(l)/A(l,k); %Actualizar bl
            A(l,[1:k-1 k+1:n]) = A(l,[1:k-1 k+1:n]) / A(l,k); %Actualizar akj
            A(l,l) = 1/(A(l,k)); %Actualizar akl
            B=union(setdiff(B,l), k);
            N=union(setdiff(N,k), l);
        end %if
    else
        ban=1;
        disp('Solucion optima encontrada');
    end %if
end %while
x=x(1:n);
end