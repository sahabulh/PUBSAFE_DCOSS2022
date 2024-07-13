function [pos] = genPos3D_Ground(source,distance,n)
z = zeros(n,1);
x = source(1) + randsrc(n,1).*((distance^2 - source(3)^2).^(1/2)).*rand(n,1);
y = source(2) + randsrc(n,1).*(distance^2 - source(3)^2 - (x-source(1)).^2).^(1/2);
pos = [x y z];
end