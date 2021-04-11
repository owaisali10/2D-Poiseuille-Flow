function R=tofx_c(dx,nx,ny,T)

for i = 1:nx
    for j=1:ny
        if i==1
            R(i,j) = (1/(2*dx)) * (T(i+1,j)-T(nx,j));
        elseif i==nx
            R(i,j) = (1/(2*dx)) * (T(1,j)-T(i-1,j));
        else
            R(i,j) = (1/(2*dx)) * (T(i+1,j)-T(i-1,j));
        end
    end

end