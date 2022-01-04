clc;
clear;
close all;

% Indicaciones: 
% * Revise y estudie el codigo, es bastante repetitivo
% * Debe conocer bien la teoria
% * Algunas funciones usadas:
%       - figure(n)     : Crear la ventana numero n para graficar
%       - hold on       : Activa el modo de sobregraficar en la misma ventana n
%       - syms 'x'      : Crea una variable simbolica 'x'
%       - expm(p)       : e^p cuando p es una matriz
%       - eye(n)        : Crea una matriz identidad de dimension 'n x n'
%       - subplot(f,c,n): Parte una figura creada previamente en 'f x c' partes
%                         y prepara la posicion 'n' para graficar sobre ella.
%       - int(f,v,a,b)  : Integral de 'f' con variable de integracion 'v' con
%                         limites de integracion desde 'a' hasta 'b'
%       - ilaplace(G)   : Trasnformada Inversa de Laplace de 'G'. 'G' debe
%                         estar en funcion de una variable simbolica 's'
%       - subs(f,b)     : Sustitucion simple. Sustituye la unica variable
%                         simbolica que debe tener 'f' (con cualquier letra)
%                         por el valor de 'b'


% Sean las matrices de algun sistema de orden 3

A = [-0.4 1 0; -4 0 40; 0 0 -4];
B = [0; 0; 2];
C = [1 0 0];
D = [0];
% ---------- Respuesta Completa (entrada esacalon unitario) ----------

figure(1)
hold on;

% 1) Usando la definicion en el dominio del tiempo
syms 't';

x0 = [0.34 0 0]';
xt = expm(A*t)*x0 + int(expm(A*(t-tao))*B, tao, 0, t);

t = 0:0.01:10;
x1t = subs(xt(1),t);
x2t = subs(xt(2),t);
x3t = subs(xt(3),t);

subplot(3,1,1);
plot(t,x1t,t,x2t,t,x3t);
title("Respuesta Completa (u => escalon unitario, c.i. => [0.34 0 0]') usando la definicion en el dominio del tiempo");
legend('x1(t)','x2(t)','x3(t)');

% 2) Usando la transformada de laplace
syms 's';

x0 = [0.34 0 0]';
u = 1/s;
xt = ilaplace((s*I-A)^-1*x0 + (s*I-A)^-1*B*u);

t = 0:0.01:10;
x1t = subs(xt(1),t);
x2t = subs(xt(2),t);
x3t = subs(xt(3),t);

subplot(3,1,2);
plot(t,x1t,t,x2t,t,x3t);
title("Respuesta Completa (u => escalon unitario, c.i. => [0.34 0 0]') usando la transformada de Laplace");
legend('x1(t)','x2(t)','x3(t)');

% 3) Usando la funcion lsim() de matlab

u = ones(size(t));
t = 0:0.01:10;
x0 = [0.34 0 0]';
[~,xt] = lsim(A,B,C,D,u,t,x0);

x1t = xt(:,1);
x2t = xt(:,2);
x3t = xt(:,3);

subplot(3,1,3);
plot(t,x1t,t,x2t,t,x3t);
title("Respuesta Completa (u => escalon unitario, c.i. => [0.34 0 0]') usando la funcion lsim()");
legend('x1(t)','x2(t)','x3(t)');
