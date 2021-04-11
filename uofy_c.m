function R=uofy_c(dy,nx,ny,u)

for i = 1:nx
    for j=1:ny
        if j==1
            R(i,j) = (1/(2*dy)) * (-3*u(i,j)+4*u(i,j+1)-u(i,j+2));
        elseif j==ny
            R(i,j) = (1/(2*dy)) * (3*u(i,j)-4*u(i,j-1)+u(i,j-2));
        else
            R(i,j) = (1/(2*dy)) * (u(i,j+1)-u(i,j-1));
        end
    end

end

end