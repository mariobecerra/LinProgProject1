function [x, fx, ban, iter] = NuevaVersion(c, A, b)
[m,n]=size(A);
I=eye(m);
A=[A,I];
c=[c,zeros(m)];
B=(n+1):(n+m);
N=1:n;
x=[zeros(n,1),b'];
fx=c'.*x;
%while(ban~=0 && ban~=-1 && ban~=1)
if(sum(c>0)>0)
    k=first(c>0);%Regla de Bland
    aux=A(:,k)>0;
    temp=b(aux)./A(aux,k);
    l=min(find(temp==min(temp))); %En caso de empate escoge el de índice más pequeño
    if(sum(l)==0)
        ban=0;
        disp('el problema no es acotado suériormente');
    end
    
else
    ban=1;
end
end