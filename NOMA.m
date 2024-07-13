function [time] = NOMA(I,U,B,connection)
c = 3e8;
phi = 11.95;
beta = 0.14;
etaLoS = 3;
etaNLoS = 23;
fc = 2e9;
av = 2;
W = 100e6;
No = -174;

nS = size(I,1);
nU = size(U,1);
R = zeros(1,nS);
P = 2*ones(1,nS);

for i = 1:nU
    d = vecnorm((I-U(i,:))');
    theta = (180/pi)*asin(U(i,3)'./d);
    PrLoS = 1./(1+phi*exp(-beta*(theta-phi)));
    PLLoS = (10^(etaLoS/10))*(4*pi*fc*d/c).^av;
    PLNLoS = (10^(etaNLoS/10))*(4*pi*fc*d/c).^av;
    PL = PrLoS.*PLLoS + (1-PrLoS).*PLNLoS;
    h_tilde = 1;
    % h_tilde = sqrt(1/2)*(randn(1,1) + 1i*randn(1,1));
    H = sqrt(1./PL).*h_tilde;
    G = (abs(H)).^2;
    sigma = W*10^((No-30)/10);
    ind = find(connection==i);
    G = G(ind);
    P2 = P(ind);
    % NOMA START
    [Gs,idx] = sort(G);
    PG = P2(idx).*Gs;
    In = zeros(1,length(ind));
    for n = 1:length(ind)
        for m = 1:(n-1)
            In(n) = In(n) + PG(m);
        end
        In(n) = In(n) + sigma;
    end
    [~,idx2] = sort(idx);
    In = In(idx2);
    PG = PG(idx2);
    % NOMA END
    Sc = PG./In;
    Rc = W*log2(1+Sc);
    R(1,ind) = Rc;
end
time = B./R;
end