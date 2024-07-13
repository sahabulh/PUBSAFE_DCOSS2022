function P = gen_poly(X,Y,r,n,t)
a = 360/n;

theta = t + pi*(0:a:360)/180;
x = r.*cos(theta);
y = r.*sin(theta);
x(end) = [];
y(end) = [];
z = zeros(1,n);
P = [x+X;y+Y;z]';