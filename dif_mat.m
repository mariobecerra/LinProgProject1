function D=dif_mat(A,B)
%D=A(~ismember(A,B,'rows'),:);
D=A(~ismem(A, B),:);

