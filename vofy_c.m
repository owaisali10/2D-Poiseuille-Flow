function R=vofy_c(dy,nx,ny,v)

for i = 1:nx
    for j=1:ny
        if j==1
            R(i,j) = (1/(2*dy)) * (-3*v(i,j)+4*v(i,j+1)-v(i,j+2));
        elseif j==ny
            R(i,j) = (1/(2*dy)) * (3*v(i,j)-4*v(i,j-1)+v(i,j-2));
        else
            R(i,j) = (1/(2*dy)) * (v(i,j+1)-v(i,j-1));
        end
    end

end

end