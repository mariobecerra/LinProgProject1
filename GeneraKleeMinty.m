function [ c, A, b ] = GeneraKleeMinty( n )
%Genera el problema de Klee Minty n-dimensional
%Mauricio Vueltiflor Gil 000131077
%Mario Becerra Contreras 000124362
%José Carlos Castro Montes 000127049    
%Aaron López Flores 000124432
c=ones(n,1);
b=ones(n,1);
for i=2:n
    c(i)=c(i-1)*10;
    b(i)=b(i-1)*100;
end

c1=zeros(n,1);

for k=1:n
    c1(k)=c(n-k+1);
end


A=eye(n);
for j=1:n-1
    A(j+1:n,j)=2*c(2:n-j+1);
end
c=c1;

end