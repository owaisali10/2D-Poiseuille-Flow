function R=new_c(w,nx,ny,gamma,umax)
rho_c = w(1:nx,:);
u_c = w(nx+1:2*nx,:)./rho_c;
v_c = w(2*nx+1:3*nx,:)./rho_c;
E_c = w(3*nx+1:4*nx,:)./rho_c;
p_c = (E_c - (1/2)*(u_c.^2+v_c.^2)).*(rho_c)*(gamma-1);
T_c = p_c./rho_c;

%Enforce Boundary Conditions

u_c(:,1)=0;
u_c(:,ny)=0;

v_c(:,1)=0;
v_c(:,ny)=0;

T_c(:,1)=1;
T_c(:,ny)=1;

p_c(:,1)=p_c(:,2);
p_c(:,ny)=p_c(:,ny-1);


rho_c=p_c./T_c;
E_c=p_c./(rho_c.*(gamma-1))+(1/2).*(u_c.^2+v_c.^2);


R=[rho_c;rho_c.*u_c;rho_c.*v_c;rho_c.*E_c];