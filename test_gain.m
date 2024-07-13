n = 100;
I = [0,0,0];
U = [0,10,0];

H = zeros(n,3);
G = zeros(n,3);
R = zeros(n,3);
P = zeros(1,n);
T = zeros(1,n);

for i = 1:n
    U(3) = i;
    [H(i,:),G(i,:),R(i,:),P(i),T(i)] = calc_gain(I,U);
end

subplot(1,2,1)
plot(H(:,1),'r');
hold on;
plot(H(:,2),'b');
hold on;
plot(H(:,3),'g');
hold on;

subplot(1,2,2)
plot(R(:,1),'r');
hold on;
plot(R(:,2),'b');
hold on;
plot(R(:,3),'g');
hold on;