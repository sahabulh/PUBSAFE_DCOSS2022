function [] = graph_CM(name)
ext = '/results_CT';
data1 = load([char(name(1)) ext]);
data2 = load([char(name(2)) ext]);
data3 = load([char(name(3)) ext]);
data4 = load([char(name(4)) ext]);
data5 = load([char(name(5)) ext]);
foldername = 'comparative_' + string(round(now*1e5));
mkdir(foldername);

% Allocated CPU
I = [data1.cpu; data2.cpu; data3.cpu; data4.cpu; data5.cpu]/1e9;
yl = "Allocated CPU (GHz)";
t = graph_RN5(I,yl);
exportgraphics(t,[char(foldername) '/cm1_cpun.png'],'BackgroundColor','none','Resolution',300)

% Computation time
I = [data1.cmtm; data2.cmtm; data3.cmtm; data4.cmtm; data5.cmtm];
yl = "Computation Time (s)";
t = graph_RN5(I,yl);
exportgraphics(t,[char(foldername) '/cm2_cmtm.png'],'BackgroundColor','none','Resolution',300)

% Transmission time
I = [data1.trtm; data2.trtm; data3.trtm; data4.trtm; data5.trtm];
yl = "Transmission Time (s)";
t = graph_RN5(I,yl);
exportgraphics(t,[char(foldername) '/cm3_trtm.png'],'BackgroundColor','none','Resolution',300)

% Latency
I = [data1.ltnc; data2.ltnc; data3.ltnc; data4.ltnc; data5.ltnc];
yl = "Latency (s)";
t = graph_RN5(I,yl);
exportgraphics(t,[char(foldername) '/cm4_ltnc.png'],'BackgroundColor','none','Resolution',300)