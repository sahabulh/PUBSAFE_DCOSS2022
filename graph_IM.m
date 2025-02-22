function [] = graph_IM(name)
temp = split(name,'/');
foldername = temp{1};
% Allocated CPU
t = graph_RN4(name,'cpu','Average Allocated CPU (Hz)');
exportgraphics(t,[foldername '/im1_cpun.png'],'BackgroundColor','none','Resolution',300)

% Computation time
t = graph_RN4(name,'cmtm','Computation Time (s)');
exportgraphics(t,[foldername '/im2_cmtm.png'],'BackgroundColor','none','Resolution',300)

% Transmission time
t = graph_RN4(name,'trtm','Transmission Time (s)');
exportgraphics(t,[foldername '/im3_trtm.png'],'BackgroundColor','none','Resolution',300)

% Latency
t = graph_RN4(name,'ltnc','Latency (s)');
exportgraphics(t,[foldername '/im4_ltnc.png'],'BackgroundColor','none','Resolution',300)