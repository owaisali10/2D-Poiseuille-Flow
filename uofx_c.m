function R=uofx_c(dx,nx,ny,u)

for i = 1:nx
    for j=1:ny
        if i==1
            R(i,j) = (1/(2*dx)) * (u(i+1,j)-u(nx,j));
        elseif i==nx
            R(i,j) = (1/(2*dx)) * (u(1,j)-u(i-1,j));
        else
            R(i,j) = (1/(2*dx)) * (u(i+1,j)-u(i-1,j));
        end
    end

end

end