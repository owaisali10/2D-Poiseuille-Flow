function R=tofy_c(dy,nx,ny,T)

for i = 1:nx
    for j=1:ny
        if j==1
            R(i,j) = (1/(2*dy)) * (-3*T(i,j)+4*T(i,j+1)-T(i,j+2));
        elseif j==ny
            R(i,j) = (1/(2*dy)) * (3*T(i,j)-4*T(i,j-1)+T(i,j-2));
        else
            R(i,j) = (1/(2*dy)) * (T(i,j+1)-T(i,j-1));
        end
    end

end

end