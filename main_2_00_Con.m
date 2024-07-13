nU = 3;
nS = 20;

UAV = gen_poly(0,0,20,nU,0.1) + [0,0,50];

% CPU = 5*ones(1,nU);
CPU = [2 2.5 3]*1e9;

connection = zeros(nS,1);
% B = [500 500 50 500 50 50 50 50 50]*1e6;
B = ones(1,nS)*5e6;
S = [0.9*ones(1,6) 0.7*ones(1,7) 0.3*ones(1,7)];
T = [linspace(0.6,0.4,6) linspace(0.7,0.5,7) linspace(0.6,0.4,7)];
idx = randperm(nS);
S = S(idx);
T = T(idx);
W = [0.8 0.2];
alpha = 0.01;
type_max = W(1)*max(S) + W(2)*max(T);
type_min = W(1)*min(S) + W(2)*min(T);
type = (W(1)*S + W(2)*T - type_min)/(type_max-type_min);
% type = 0.5*(((1-alpha.^type)/(1-alpha))+1);
type = 0.45*type + 0.50;
type(type>1)=1;

USER = [gen_poly(0,0,55,6,0);gen_poly(0,0,50,7,0);gen_poly(0,0,45,7,0)];
USER = USER(idx,:);

reward_param = 0.05;
P = ones(nS,nU)*(1/nU);
% Max iteration
max_ite = 10000;
% Convergence variable
max_wait = 10;

conv = zeros(nS,1);
conv_check = zeros(nS,1);
reward = zeros(nS,1);
prev_R = -1*ones(nS,1);

RWRD = zeros(max_ite,nS);
EFRT = zeros(max_ite,nS);
USUT = zeros(max_ite,nS);
ACPU = zeros(max_ite,nS);
LTNC = zeros(max_ite,nS);
TRTM = zeros(max_ite,nS);
CMTM = zeros(max_ite,nS);

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

    RWRD(ite,:) = r';
    EFRT(ite,:) = r'./type;
    X = EFRT(ite,:)./type;
    USUT(ite,:) = type.*sqrt(r') - k*EFRT(ite,:);
    ACPU(ite,:) = cpun'.*CPU(connection);
    TRTM(ite,:) = NOMA(USER,UAV,X.*B,connection);
    CMTM(ite,:) = 100*X.*B./ACPU(ite,:);
    LTNC(ite,:) = TRTM(ite,:) + CMTM(ite,:);
    
    for i = 1:nS
        if conv(i)
            continue;
        end
        n = connection(i);
        reward(i) = 1/sum(connection == n);
    
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
et = toc;

r = zeros(nS,1);
cpun = zeros(nS,1);

for i = 1:nS
    connection(i) = find(P(i,:)==1);
end

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

[t,idx] = sort(type);
ri = r(idx)';
qi = ri./t;
rc = (t/(2*c*k)).^2;
qc = (t.^2)/(2*c*(k^2));

x = qi./t;
cpu = cpun'.*CPU(connection);
trtm = NOMA(USER(idx,:),UAV,x.*B(idx),connection(idx));
cpu = cpu(idx);
cmtm = 100*x.*B(idx)./cpu;
ltnc = trtm + cmtm;
connection = connection(idx);

Iuser_utility = t.*sqrt(ri) - k*qi;
Imarket_values = qi - c*ri;
Cuser_utility = t.*sqrt(rc) - k*qc;
Cmarket_values = qc - c*rc;

Imarket_utility = zeros(1,nS);
Isw_values = zeros(1,nS);
Cmarket_utility = zeros(1,nS);
Csw_values = zeros(1,nS);

for j = 1:nS
    Imarket_utility(j) = sum(Imarket_values(1:j));
    Isw_values(j) = sum(Imarket_values(1:j)) + sum(Iuser_utility(1:j));
    Cmarket_utility(j) = sum(Cmarket_values(1:j));
    Csw_values(j) = sum(Cmarket_values(1:j)) + sum(Cuser_utility(1:j));
end

name = 'resultsCON_' + string(round(now*1e5));
mkdir(name);
save(name+'/probabilites','P');
save(name+'/results_CT','t','ri','qi','Iuser_utility','Imarket_utility','Isw_values','rc','qc','Cuser_utility','Cmarket_utility','Csw_values','cpu','trtm','cmtm','ltnc','connection','idx','S');
save(name+'/results_RL','RWRD','EFRT','USUT','ACPU','LTNC','TRTM','CMTM','ite','et','conv','type');