function [SNR,R] = NOMA_UP(P,G,W)
nS = length(P);
No = -174;
[Gs,idx] = sort(G);
sigma = W*10^((No-30)/10);
PG = P(idx).*Gs;
In = zeros(1,nS);
for n = 1:nS
    for m = 1:(n-1)
        In(n) = In(n) + PG(m);
    end
    In(n) = In(n) + sigma;
end
[~,idx2] = sort(idx);
In = In(idx2);
PG = PG(idx2);
SNR = PG./In;
R = W*log2(1+SNR);