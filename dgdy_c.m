function R=dgdy_c(G,nx,ny,dy)
for i=1:nx
    for j=1:ny
        if j==1
            R(i,j) = (1/(2*dy)) * (-3*G(i,j)+4*G(i,j+1)-G(i,j+2));
        elseif j==ny
            R(i,j) = (1/(2*dy)) * (3*G(i,j)-4*G(i,j-1)+G(i,j-2));
        else
            R(i,j) = (1/(2*dy)) * (G(i,j+1)-G(i,j-1));
        end
    end
end
end