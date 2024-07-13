nU = 3;
nS = 9;

UAV = gen_poly(0,0,20,nU,0.1) + [0,0,50];
USER = gen_poly(0,0,50,nS,0);

% CPU = 5*ones(1,nU);
CPU = [5 5 15];

connection = zeros(nS,1);
S = [0.3 0.7 0.9 0.3 0.7 0.9 0.3 0.7 0.9];
T = [0.5 0.7 0.7 0.7 0.7 0.5 0.5 0.5 0.7];
W = [0.8 0.2];
alpha = 0.01;
type_max = W(1)*max(S) + W(2)*max(T);
type = (W(1)*S + W(2)*T)/type_max;
type = 0.4*(((1-alpha.^type)/(1-alpha))+1.5);
type(type>1)=1;

reward_param = 0.1;
P = ones(nS,nU)*(1/nU);
% Max iteration
max_ite = 10000;
% Convergence variable
max_wait = 10;

conv = zeros(nS,1);
conv_check = zeros(nS,1);
reward = zeros(nS,1);
prev_R = -1*ones(nS,1);

tic
for ite = 1:max_ite
    for i = 1:nS
        connection(i) = randsample(nU,1,true,P(i,:));
    end
    
    r = zeros(nS,1);
    cpun = zeros(nS,1);

    for i = 1:nU
        idx = find(connection == i);
        t = type(idx);
        N = length(t);
    
        f = ones(1,N);
        F = unifcdf(t);
    
        c = 0.75;
        k = 0.8;
    
        options = optimoptions(@fmincon,'MaxFunctionEvaluations',30000,'Algorithm','interior-point','Display','off');
    
        for j = 1:N
            fun = @(x) -f(j)*((t(j)/k)*sqrt(x) - c*x - ((1/k)*sqrt(x) * ((1-F(j))/f(j))));
            x0 = 0.5;
            [x,~,~,~] = fmincon(fun,x0,[1/t(j);-1/t(j)],[1;-0.01],[],[],0,1,[],options);
            r(idx(j)) = x;
        end
        cpun(idx) = r(idx)/sum(r(idx));
    end
    
    for i = 1:nS
        if conv(i)
            continue;
        end
        n = connection(i);
        reward(i) = cpun(i)*CPU(n)/max(CPU);
    
        for st = 1:nU
            if st == n
                P(i,st) = P(i,st) + reward_param*reward(i)*(1 - P(i,st));
            else
                P(i,st) = (1 - reward_param*reward(i))*P(i,st);
            end
        end

        % Check convergence
        if abs(reward(i)-prev_R(i)) < 0.01 && conv_check(i) == max_wait
            conv(i) = ite;
            [~,idx] = max(P(i,:));
            P(i,:) = zeros(1,nU);
            P(i,idx) = 1;
        elseif abs(reward(i)-prev_R(i)) < 0.01
            conv_check(i) = conv_check(i) + 1;
        else
            conv_check(i) = 0;
        end
        prev_R(i) = reward(i);
    end

    if sum(conv~=0) == nS
        break;
    end
end
toc
save('probabilites','P');