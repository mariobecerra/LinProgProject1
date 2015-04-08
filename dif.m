function D=dif(A,B)
%D=A(~ismember(A,B));
%A y B deben de estar ordenados para que funcione como ismember
D=A(~ismembc(A,B));