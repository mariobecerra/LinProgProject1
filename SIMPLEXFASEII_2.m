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
b=[zeros(1,n) b']';
x(B)=b(B)+A(:,N)*x(N);
iter=0;
ban=2;
while(ban==2 & iter<5000)
    iter=iter+1
    if (sum(c>0) > 0) 
        k=min(find(c>0))
        temp=zeros(m,1)+Inf;
        temp(b(B)./A(:,k)>0)=0;
        temp=temp+(b(B)./A(:,k));
        l=min(find(temp==min(temp)))+n; %En caso de empate escoge el de índice más pequeño
        if(sum(l == 0) | sum(temp)==0 | sum(temp==Inf)==m)   
            ban=0;
            disp('El problema no es acotado');
            break;
        else
            %x(l)=b(l)-A(l,N)*x(N);
            x(k)=(1/A(l-n,k))*(b(l) - x(l) - A(l-n,setdiff(N,k))*x(setdiff(N,k)));
            fx=fx+c(k)*b(l)/A(l-n,k); %Actualizar func obj
            if(sum(c(k)>0))
                c(k) = c(k) - c(k)*A(l-n,setdiff(N,k))'/A(l-n,k); %Act cj pa todo j No básica menos k
            end
            c(k)=-c(k)/A(l-n,k); %Actualizar ck
            if(sum(b(setdiff(B,l)))==0)
                b(setdiff(B,l)) = b(setdiff(B,l)) - A(setdiff(B,l)-n,k)'*b(l)/A(l-n,k); %Actualizar bi pa todo i Básica menos l
            else
                b(setdiff(B,l)) = b(setdiff(B,l)) - A(setdiff(B,l)-n,k)*b(l)/A(l-n,k);
            end
            sa = b(setdiff(B, l)) - A(setdiff(B, l)-n,k)*b(l)/A(l-n,k);
            sb = - A(setdiff(B, l)-n,k)*x(k)/A(l-n,k);
            sc = A(setdiff(B,l)-n,setdiff(N,k))*x(setdiff(N,k));
            sd = - (A(setdiff(B, l)-n, setdiff(N,k)) - A(l-n, setdiff(N,k)) - A(setdiff(B, l)-n,k))*x(setdiff(N,k));
            x(setdiff(B, l)) = sa+sb+sc+sd;
            %x(setdiff(B, l))=b(setdiff(B, l)) - A(setdiff(B, l),k)*b(l)/A(l,k) - A(setdiff(B, l),k)*x(k)/A(l,k)- (A(setdiff(B, l), setdiff(N,k)) - A(l, setdiff(N,k)) - A(setdiff(B, l),k))*x(setdiff(N,k));
            A(setdiff(B, l)-n, setdiff(N,k)) = A(setdiff(B, l)-n, setdiff(N, k)) - (1/A(l-n,k)) * A(setdiff(B, l)-n,k) * A(l-n,setdiff(N,k)); %Actualizar aij pa todo j No básico menos k y todo i Básica menos l
            A(setdiff(B, l)-n, l) = A(setdiff(B, l)-n, k) / A(l-n,k); %Actualizar ail para todo i Básica menos l
            b(l) = b(l)/A(l-n,k); %Actualizar bl
            A(l-n,setdiff(N,k)) = A(l-n,setdiff(N,k)) / A(l-n,k); %Actualizar akj
            A(l-n,l) = 1/(A(l-n,k)); %Actualizar akl
            B=union(setdiff(B,l), k)
            N=union(setdiff(N,k), l)
        end %if
    else
        ban=1;
        disp('Solucion optima encontrada');
    end %if
end %while
x=x(1:n);
end