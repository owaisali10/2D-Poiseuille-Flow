function R=vofx_c(dx,nx,ny,v)

for i = 1:nx
    for j=1:ny
        if i==1
            R(i,j) = (1/(2*dx)) * (v(i+1,j)-v(nx,j));
        elseif i==nx
            R(i,j) = (1/(2*dx)) * (v(1,j)-v(i-1,j));
        else
            R(i,j) = (1/(2*dx)) * (v(i+1,j)-v(i-1,j));
        end
    end

end

end