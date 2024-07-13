function [] = graph_RL(name)
temp = split(name,'/');
foldername = temp{1};
% Reward
t = graph_RN3(name,'RWRD','Contract Theory Reward');
exportgraphics(t,[foldername '/rl1_rwrd.png'],'BackgroundColor','none','Resolution',300)

% Effort
t = graph_RN3(name,'EFRT','Effort');
exportgraphics(t,[foldername '/rl2_efrt.png'],'BackgroundColor','none','Resolution',300)

% User utility
t = graph_RN3(name,'USUT','User Utility');
exportgraphics(t,[foldername '/rl3_usut.png'],'BackgroundColor','none','Resolution',300)

% Allocated CPU
t = graph_RN3(name,'ACPU','Allocated CPU (Hz)');
exportgraphics(t,[foldername '/rl4_cpun.png'],'BackgroundColor','none','Resolution',300)

% Computation time
t = graph_RN3(name,'CMTM','Computation Time (s)');
exportgraphics(t,[foldername '/rl5_cmtm.png'],'BackgroundColor','none','Resolution',300)

% Transmission time
t = graph_RN3(name,'TRTM','Transmission Time (s)');
exportgraphics(t,[foldername '/rl6_trtm.png'],'BackgroundColor','none','Resolution',300)

% Latency
t = graph_RN3(name,'LTNC','Latency (s)');
exportgraphics(t,[foldername '/rl7_ltnc.png'],'BackgroundColor','none','Resolution',300)