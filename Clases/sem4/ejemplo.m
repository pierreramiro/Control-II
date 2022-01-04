A=[ 0 1 0; 0 0 1; -1 -5 -6];
B=[0;0;1];

syms s
I=eye(2);
det(s*eye(3)-A);
P=[1 6 5 1];
a1=6;a2=5;a3=1;
M=[B A*B A^2*B];
W=[P(3) P(2) 1;P(2) 1 0;1 0 0];
T=M*W;%y está en la forma canónica. T es la identidad

s1=-2+4i;
s2=-2-4i;
s3=-10;
pol_des=conv([1 -s1],conv([1 -s2],[1 -s3]));
alfa1=pol_des(2);
alfa2=pol_des(3);
alfa3=pol_des(4);
K=[alfa3-a3 alfa2-a2 alfa1-a1];

%Por Formula de Ackermann
phi=A^3+alfa1*A^2+alfa2*A+alfa3*eye(3);
K_ack=[0 0 1]*M^-1*phi;
%funciones matlab
K_ack_matlab=acker(A,B,[s1 s2 s3]);%valido solo para SISO
K_place_matlab=place(A,B,[s1 s2 s3]);%valido para MIMO
