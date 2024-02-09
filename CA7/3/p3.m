clc;
close all;
clear;

fs = 50;
ts = 1/fs;
t_end=10;
t_start=0;
t= 0:ts: 10;
N = (t_end - t_start) / ts;

syms y(t);
Dy = diff(y);

ode = diff(y,t,2) + 3* diff(y,t,1) + 2*y == 5 * heaviside(t);
cond1 = y(0) == 1;
cond2 = Dy(0) == 1;
conds = [cond1 cond2];
ySol(t) = dsolve(ode,conds);
ySol(t) = simplify(ySol(t));

fs = 50;
ts = 1/fs;
t_end=10;
t_start=0;
t= 0:ts: 10;

figure;
plot(t,ySol(t));
