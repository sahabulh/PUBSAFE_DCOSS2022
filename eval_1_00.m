N = 1000;

for ite = 1:N
    for i = 1:nS
        connection(i) = randsample(nU,1,true,P(i,:));
    end