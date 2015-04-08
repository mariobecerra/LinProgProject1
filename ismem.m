function D=ismem(A,B)
% [n,m]=size(A);
% for i =1:n
% 	for j=1:m
% 		D(i)=all(ismembc(A(i,:),B(i,:))==1);
% end
% D=D';

[n,~]=size(B);
D=0;
for i=1:n
	D=D+all((repmat(B(i,:),size(A,1),1)==A)')';
end

