function D=ismem(A,B)
[~,n]=size(B);
for i =1:n
	D(i)=all(ismembc(A(i,:),B(i,:))==1);
end
D=D';