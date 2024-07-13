cpu = zeros(1,20);
cmtm = zeros(1,20);
trtm = zeros(1,20);
ltnc = zeros(1,20);
mite = 0;
met = 0;
for i = 1:10
    name = ['results_' char(string(i))];
    data = load([name '\results_RL']);
    if data.ite > mite
        mite = data.ite;
        met = data.et;
    end
end
type = data.type;
ACPU = zeros(mite,20);
CMTM = zeros(mite,20);
TRTM = zeros(mite,20);
LTNC = zeros(mite,20);
for i = 1:10
    name = ['results_' char(string(i))];
    data = load([name '\results_RL']);
    if data.ite < mite
        data.ACPU(data.ite+1:mite,:) = ones(mite-data.ite,20).*data.ACPU(data.ite,:);
        data.CMTM(data.ite+1:mite,:) = ones(mite-data.ite,20).*data.CMTM(data.ite,:);
        data.TRTM(data.ite+1:mite,:) = ones(mite-data.ite,20).*data.TRTM(data.ite,:);
        data.LTNC(data.ite+1:mite,:) = ones(mite-data.ite,20).*data.LTNC(data.ite,:);
    end
    ACPU = ACPU + data.ACPU(1:mite,:)/10;
    CMTM = CMTM + data.CMTM(1:mite,:)/10;
    TRTM = TRTM + data.TRTM(1:mite,:)/10;
    LTNC = LTNC + data.LTNC(1:mite,:)/10;
    data = load([name '\results_CT']);
    cpu = cpu + data.cpu/10;
    cmtm = cmtm + data.cmtm/10;
    trtm = trtm + data.trtm/10;
    ltnc = ltnc + data.ltnc/10;
end
idx = data.idx;
S = data.S;
SACPU = zeros(mite,20);
SCMTM = zeros(mite,20);
STRTM = zeros(mite,20);
SLTNC = zeros(mite,20);
for i = 1:10
    name = ['results_' char(string(i))];
    data = load([name '\results_RL']);
    if data.ite < mite
        data.ACPU(data.ite+1:mite,:) = ones(mite-data.ite,20).*data.ACPU(data.ite,:);
        data.CMTM(data.ite+1:mite,:) = ones(mite-data.ite,20).*data.CMTM(data.ite,:);
        data.TRTM(data.ite+1:mite,:) = ones(mite-data.ite,20).*data.TRTM(data.ite,:);
        data.LTNC(data.ite+1:mite,:) = ones(mite-data.ite,20).*data.LTNC(data.ite,:);
    end
    SACPU = SACPU + (ACPU - data.ACPU(1:mite,:)).^2;
    SCMTM = SCMTM + (CMTM - data.CMTM(1:mite,:)).^2;
    STRTM = STRTM + (TRTM - data.TRTM(1:mite,:)).^2;
    SLTNC = SLTNC + (LTNC - data.LTNC(1:mite,:)).^2;
end
SACPU = sqrt(SACPU/10);
SCMTM = sqrt(SCMTM/10);
STRTM = sqrt(STRTM/10);
SLTNC = sqrt(SLTNC/10);
ite = mite;
et = met;
save("results_CT","cpu","cmtm","trtm","ltnc","idx","S")
save("results_RL","ACPU","CMTM","TRTM","LTNC","ite","et","type")
save("results_SD","SACPU","SCMTM","STRTM","SLTNC","ite","et","type")