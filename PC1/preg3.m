% Sean los siguientes estados
% x1=theta
% x2=Dtheta
% x3=x
% x4=Dx
M=50;m=100;l=20;g=9.81;
A=[ 0               1 0 0;
    -(M+m)*g/M/l    0 0 0;
    0               0 0 1;
    m*g/M           0 0 0];
B=[0;-1/M/l;0;1/M];
C=[l 0 1 0];
n=length(A);

Mc=[B];
Mo=[C];
for i=1:n-1
    Mc = [Mc,A^i*B];
    Mo = [Mo;C*A^i];
end
rango_MC=rank(Mc)
rango_MO=rank(Mo)
%%
t=2;
vpa(expm(A*t),3)

%%
x0=[0.2 0 0 0];
t=0:0.01:50;
u = zeros(size(t));
[~,xt] = lsim(A,B,C,D,u,t,x0);
temp='plot(';
for i=1:n
    eval(sprintf('x%dt = xt(:,%d);',i,i));
    temp=strcat(temp,'t,x',num2str(i),'t,');
end
temp=strcat(temp(1:end-1),');');
eval(temp);
legend('theta','Dtheta','x','Dx')
grid
title('Respuesta a condiciones iniciales')