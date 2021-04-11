function S = P_rk44(w,nx,ny,dx,dy,gamma,K,Mue,g)
rho_c = w(1:nx,:);
u_c = w(nx+1:2*nx,:)./rho_c;
v_c = w(2*nx+1:3*nx,:)./rho_c;
E_c = w(3*nx+1:4*nx,:)./rho_c;
p_c = (E_c - (1/2)*(u_c.^2+v_c.^2)).*(rho_c)*(gamma-1);
T_c = p_c./rho_c;

%Derivatives
dudx=uofx_c(dx,nx,ny,u_c);
dudy=uofy_c(dy,nx,ny,u_c);

dvdx=vofx_c(dx,nx,ny,v_c);
dvdy=vofy_c(dy,nx,ny,v_c);

dTdx=tofx_c(dx,nx,ny,T_c);
dTdy=tofy_c(dy,nx,ny,T_c);

%Substituting Derivatives to get viscous parameters
qx=-K*dTdx;
qy=-K*dTdy;
Txx=(2/3)*Mue*(2*dudx-dvdy);
Tyy=(2/3)*Mue*(2*dvdy-dudx);
Txy=Mue*(dudy+dvdx);

%Defining Source term
V=sqrt(u_c.^2+v_c.^2);

a=zeros(nx,ny);
b=zeros(nx,ny);
c=zeros(nx,ny);
d=zeros(nx,ny);

b(:)=g;%g
d(:)=g.*V;%gv

Source=[a;b;c;d];



for m=1:4
    clear F G R
    if m==1
        F=rho_c.*u_c+0;
        G=rho_c.*v_c+0;
        So=a;
    elseif m==2
        F=rho_c.*u_c.^2+p_c-Txx;
        G=rho_c.*u_c.*v_c-Txy;
        So=b;
    elseif m==3
        F=rho_c.*u_c.*v_c-Txy;
        G=rho_c.*v_c.^2+p_c-Tyy;
        So=c;
    elseif m==4
        F=u_c.*(rho_c.*E_c+p_c)+qx-u_c.*Txy-v_c.*Tyy;
        G=v_c.*(rho_c.*E_c+p_c)+qy-u_c.*Txy-v_c.*Tyy;
        So=d;
    end       
 
    R = -dfdx_c(F,nx,ny,dx)-dgdy_c(G,nx,ny,dy)+So;%Differentitating
     
    if m==1
        ra=R;
    elseif m==2
        rb=R;
    elseif m==3
        rc=R;
    elseif m==4
        rd=R;
    end
end

S = [ra;rb;rc;rd];