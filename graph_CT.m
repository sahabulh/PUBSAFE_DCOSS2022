function [] = graph_CT(name)
data = load(name);
temp = split(name,'/');
foldername = temp{1};
% Reward
I = data.ri;
C = data.rc;
yl = "Contract Theory Reward";
t = graph_RN1(I,C,yl);
exportgraphics(t,[foldername '/ct1_rwrd.png'],'BackgroundColor','none','Resolution',300)

% Effort
I = data.qi;
C = data.qc;
yl = "Effort";
t = graph_RN1(I,C,yl);
exportgraphics(t,[foldername '/ct2_efrt.png'],'BackgroundColor','none','Resolution',300)

% User utility
I = data.Iuser_utility;
C = data.Cuser_utility;
yl = "User Utiity";
t = graph_RN1(I,C,yl);
exportgraphics(t,[foldername '/ct3_usut.png'],'BackgroundColor','none','Resolution',300)

% UAV utility
I = data.Imarket_utility;
C = data.Cmarket_utility;
yl = "UAV Utiity";
t = graph_RN1(I,C,yl);
exportgraphics(t,[foldername '/ct4_uvut.png'],'BackgroundColor','none','Resolution',300)

% Social welfare score
I = data.Isw_values;
C = data.Csw_values;
yl = "Social Welfare Score";
t = graph_RN1(I,C,yl);
exportgraphics(t,[foldername '/ct5_swfs.png'],'BackgroundColor','none','Resolution',300)

% Allocated CPU
I = data.cpu/1e9;
D = data.connection;
yl = "Allocated CPU (GHz)";
t = graph_RN2(I,D,yl);
exportgraphics(t,[foldername '/ct6_cpun.png'],'BackgroundColor','none','Resolution',300)

% Computation time
I = data.cmtm;
yl = "Computation Time (s)";
t = graph_RN2(I,D,yl);
exportgraphics(t,[foldername '/ct7_cmtm.png'],'BackgroundColor','none','Resolution',300)

% Transmission time
I = data.trtm;
yl = "Transmission Time (s)";
t = graph_RN2(I,D,yl);
exportgraphics(t,[foldername '/ct8_trtm.png'],'BackgroundColor','none','Resolution',300)

% Latency
I = data.ltnc;
yl = "Latency (s)";
t = graph_RN2(I,D,yl);
exportgraphics(t,[foldername '/ct9_ltnc.png'],'BackgroundColor','none','Resolution',300)