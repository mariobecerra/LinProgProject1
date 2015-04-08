function D=ismem(A,B)
[~,n]=size(B);
D=find(any(all(bsxfun(@eq,reshape(A.',1,n,[]),B),2),3)); 