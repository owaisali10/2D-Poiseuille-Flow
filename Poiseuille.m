%2D Posieuille Flow
%clc
clear all
close all

%% Variables
nx = 32;
ny = 32;
Lx = 1;
Ly = 1;
tf = 550;
dt = 0.0125;

%% Given Fixed Variables
Re = 90;
M = 0.1;
Pr = 0.71;
gamma = 1.4;
umax = M*sqrt(gamma);%Assuming R=1
u_av = 2*umax/3; %Average velocity
Mue = u_av/Re; %Assuming rho=1 and L=1
Cp = gamma/(gamma-1);
K = Mue*Cp/Pr;

%% Initialization
dx = Lx/(nx-1);
dy = Lx/(ny-1);
x = 0:dx:Lx;
y = 0:dy:Ly;
u=zeros(nx,ny);
v=zeros(nx,ny);
T=zeros(nx,ny);
rho=zeros(nx,ny);



%Boundary Conditions
u(nx,:)=0;
T(:)=1;
rho(:)=1;
p=rho.*T;
E=p./(rho.*(gamma-1))+(1/2).*(u.^2+v.^2);

g=(24/Re)*(Lx/Ly)*0.5*rho*u_av^2;%Pressure Difference

W = [rho;rho.*u;rho.*v;rho.*E];

W_t=W;
t=0;

while t<=tf
    fprintf('Loading results: %3.5f%%\n',(t/tf)*100);
    w1 = W_t;
    w1 = new_c(w1,nx,ny,gamma);
    RHS_w1 = P_rk44(w1,nx,ny,dx,dy,gamma,K,Mue,g);
    w2 = W_t + (dt/2)* RHS_w1;
    w2 = new_c(w2,nx,ny,gamma);
    RHS_w2 = P_rk44(w2,nx,ny,dx,dy,gamma,K,Mue,g);     
    w3 = W_t + (dt/2)* RHS_w2;
    w3 = new_c(w3,nx,ny,gamma);
    RHS_w3 = P_rk44(w3,nx,ny,dx,dy,gamma,K,Mue,g);     
    w4 = W_t + dt* RHS_w3;
    w4 = new_c(w4,nx,ny,gamma);
    RHS_w4 = P_rk44(w4,nx,ny,dx,dy,gamma,K,Mue,g); 
    W_t = W_t + (1/6)*dt*(RHS_w1+2*RHS_w2+2*RHS_w3+RHS_w4);
    W_t = new_c(W_t,nx,ny,gamma);
    t = t + dt;
end

%% Results
rho_t = W_t(1:nx,:);
u_t = W_t(nx+1:2*nx,:)./rho_t;
v_t = W_t(2*nx+1:3*nx,:)./rho_t;
E_t = W_t(3*nx+1:4*nx,:)./rho_t;
p_t = (E_t - (1/2)*(u_t.^2+v_t.^2)).*(rho_t)*(gamma-1);
T_t = p_t./rho_t;
u_mag=sqrt(u_t.^2+v_t.^2);

%% Plotting
figure(1)
[C,h] = contourf(x,y,u_mag.',50, 'edgecolor', 'none');
colorbar;
%colormap(jet);
clabel(C,h);
str = sprintf('Contour of Velocity Magnitude Nx=Ny=%d and tf=%d ', nx,tf);
title(str);

figure(2)
plot(u_mag.'./u_av,y)
hold on
u_dist=6*(y/Ly).*(1-y/Ly);
plot(u_dist,y)
str = sprintf('Streamwise vertical U velocity for Nx=Ny=%d and tf=%d ', nx,tf);
title(str);
legend('Theoretical','Numerical')
ylabel('y');
xlabel('U/U_{avg}');