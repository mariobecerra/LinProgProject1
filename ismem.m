function D=ismem(A,B)
% [n,~]=size(A);
% [m,~]=size(B);
% for i =1:n
% 	for j=1:m
% 		D(i)=all(ismembc(sort(A(i,:)),sort(B(j,:)))==1);
		
% end
% end


% [n,~]=size(B);
% D=0;
% for i=1:n
% 	D=D+all((repmat(B(i,:),size(A,1),1)==A)')';
% end

[n,~]=size(A);
D=zeros(size(B,1),1);
for i=1:n
	D=D+all(B==repmat(A(i,:),size(B,1), 1)==1,2);
end


% [n,~]=size(A);
% [m,~]=size(B);
% d=zeros(n,m);
% %D=zeros(n,1);
% for i =1:n
% 	for j=1:m
% 		d(i,j)=all(A(i,:)==B(j,:)==1);
% 		%D(i)=any(all(A(i,:)==B(j,:)==1),2);
% 	end
% end
% D=any(d,2);

% function y=ismem(a,b)

% [as,ia]=sort(a(:));
% bs=sort(b(:));
% iis=false(size(as));
% n=numel(as);
% m=numel(bs);
% i=1;
% j=1;
% while (i<=n)&&(j<=m),
%   if (as(i)>bs(j)),
%     j=j+1;
%   else
%     iis(i)=(as(i)==bs(j));
%     i=i+1;
%   end;
% end;
% y=false(size(a));
% y(ia)=iis;
% end

