function R=dfdx_c(F,nx,ny,dx)
for i=1:nx
    for j=1:ny
        if i==1
            R(i,j) = (1/(2*dx)) * (F(i+1,j)-F(nx,j));
        elseif i==nx
            R(i,j) = (1/(2*dx)) * (F(1,j)-F(i-1,j));
        else
            R(i,j) = (1/(2*dx)) * (F(i+1,j)-F(i-1,j));
        end
    end
end
end
