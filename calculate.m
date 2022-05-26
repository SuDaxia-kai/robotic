clear;
clc;
syms C1 S1 C2 S2 C3 S3 C4 S4 C45 S45 C5 S5
syms d1 d2 d3 d4 d5 d6 d7
syms a1 a2 a3 a4 a5 a6 a7
syms nx ny nz ox oy oz ax ay az px py pz
th = [0 0 C1 S1 C2 S2 C3 S3 C4 S4 1 0 C5 S5 1 0];
dz = [d1 0 0 0 d5 d6 d7];
dx = [0 a2 a3 0 0 0 0];
total = [];
ToDeg = 180/pi;
ToRad = pi/180;
global Link

for i = 2:1:8
%     dz = Link(i).dz;
%     dx = Link(i).dx;
    alf = Link(i).alf;

    C = th(2*i-1);
    S = th(2*i);
    D = dz(i-1);
    A = dx(i-1);
    T = [C, -round(cos(alf))*S,   round(sin(alf))*S,  A*C;
         S,  round(cos(alf))*C,  -round(sin(alf))*C,  A*S;
         0,    round(sin(alf)),     round(cos(alf)),    D;
         0,           0,            0,                  1];
    total = [total;T];
end

E = eye(4);
for j = 1:1:7
    E = E*total(4*(j-1)+1:j*4,:);
end


Te2p = qiuni(total(25:28,:));
T120 = qiuni(total(1:4,:));
Tp25 = qiuni(total(21:24,:));
T322 = qiuni(total(5:8,:));
T524 = qiuni(total(17:20,:));

tt = T120*E*Te2p;
E1 = eye(4);
for j = 3:1:4
    E1 = E1*total(4*(j-1)+1:j*4,:);
end
E1

T02e = [nx ox ax px;
        ny oy ay py;
        nz oz az pz;
        0  0  0  1];
final = (T322*(T120*T02e*Te2p)*Tp25)*T524


pose = eye(3);
px = 15;
py = 74;
pz = 262.5
[th1,th2,th3,th4,th5] = reverse_5(pose,px,py,pz)


