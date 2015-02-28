function [x, fx, ban, iter] = SIMPLEXFASEII (c, A, b)
% Versi ́on del Simplex en la fase II.
% Minimizar c T x
% Sujeto a Ax ≤ b
%x ≥ 0
% donde
% b ≥ 0.
% Salida
% x valor  ́optimo del problema.
% f x valos de la funci ́on objetivo en x.
% ban indica los siguientes casos: band = −1 conjunto factible vac ́ıo.
% ban == 0 funci ́on objetivo no acotada superiormente.
% ban = 1 se encontr ́o soluci ́on  ́optima.
% iter es el número de iteraciones (cambios de diccionarios) que hace el m ́etodo.
%%
% A partir de B usted puede construir el diccionario inicial.

%Para que coincidan las dimensiones
[u,v]=size(b);
if(u==1)
    b=b'
end

[u,v]=size(c);
if(u==1)
    c=c'
end

[m,n] = size(A)
x=zeros(m+n,1);
%x=b-A.*.
%A=[A,eye(m,m)];

B=(n+1):(n+m);
N=1:n;
fx=0;
iter=0;

ban=2;
%Falta bandera de conjunto vacío
%Falta número de iteraciones

while(ban==2)
    iter=iter+1;
    if (sum(c>0) > 0) 
        k=min(find(c>0))
        
        temp=zeros(m,1)+Inf;
        temp(b./A(:,k)>0)=0;
        temp=temp+(b./A(:,k));
        l=find(temp==min(temp));
        l=min(l) %En caso de empate escoge el de índice más pequeño
        if(sum(l > 0))
            %x([1:l-1 l+1:n]) = b([1:l-1 l+1:n]) - A([1:l-1 l+1:n],k)*b(l)/A(l,k);
            x(k)=b(l)/A(l,k);
            fx=fx+c(k)*b(l)/A(l,k); %Actualizar func obj
            c([1:k-1 k+1:n]) = c([1:k-1 k+1:n]) - c(k)*A(l,[1:k-1 k+1:n])'/A(l,k); %Act cj pa todo j No básica menos k
            c(k)=-c(k)/A(l,k); %Actualizar ck
            
            if(sum(b([1:l-1 l+1:m]))>0)
                b([1:l-1 l+1:m]) = b([1:l-1 l+1:m]) - A([1:l-1 l+1:m],k)*b(l)/A(l,k); %Actualizar bi pa todo i Básica menos l
                A([1:l-1 l+1:m], [1:k-1 k+1:n]) = A([1:l-1 l+1:m], [1:k-1 k+1:n]) - (1/A(l,k)) * A([1:l-1 l+1:m],k) * A(l,[1:k-1 k+1:n]); %Actualizar aij pa todo j No básico menos k y todo i Básica menos l
                A([1:l-1 l+1:m], l) = A([1:l-1 l+1:m], k) / A(l,k); %Actualizar ail para todo i Básica menos l
                b(k) = b(l)/A(l,k); %Actualizar bk
                A(k,l) = 1/(A(l,k)); %Actualizar akl
                B=union(setdiff(B,l), k);
                N=union(setdiff(N,k), l);
            else
                ban=0;
                disp('El problema no es acotado');
                break;
            end %if
        
        else     
            ban=0;
            disp('El problema no es acotado');
            break;

        end %if
    else
        ban=1;
        disp('Solucion optima encontrada');
    end %if


    %l=find(b(A(:,k)>0,k)./A(A(:,k)>0,k))==min(b(A(:,k)>0,k)./A(A(:,k)>0,k));
    %temp=b(A(:,k)>0,k)./A(A(:,k)>0,k)
    
end %while


end