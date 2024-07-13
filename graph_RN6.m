function t = graph_RN6(name,dname,y1)
font = 24;
data = load(name);
T = data.(dname);
data1 = load("results_SD.mat");
D = data1.(['S' dname]);

figure(1)
t = tiledlayout(1,1,'TileSpacing','Compact','Padding','Compact');
[~,idx] = sort(data.type);

nexttile
x = 1:ceil(data.ite);
tf = data.et/data.ite;
x = x.*tf;

y = movmean(T(1:data.ite,idx(18)),100)';
sd = movmean(D(1:data.ite,idx(18)),100)';
l1 = plot(x,y,'b','Linewidth',3);
hold on;
patch([x fliplr(x)],[y-sd fliplr(y+sd)],'b','FaceAlpha','0.3');
hold on;
y = movmean(T(1:data.ite,idx(7)),100)';
sd = movmean(D(1:data.ite,idx(7)),100)';
l2 = plot(x,y,'r','Linewidth',3);
hold on;
patch([x fliplr(x)],[y-sd fliplr(y+sd)],'r','FaceAlpha','0.3');
hold on;
y = movmean(T(1:data.ite,idx(1)),100)';
sd = movmean(D(1:data.ite,idx(1)),100)';
l3 = plot(x,y,'g','Linewidth',3);
hold on;
patch([x fliplr(x)],[y-sd fliplr(y+sd)],'g','FaceAlpha','0.3');
hold off;

xlabel("Execution time (s)");
ylabel(y1);
xlim([0 max(x)])
legend([l1,l2,l3],["Best user","Average user","Worst user"],'Location','northwest');
set(gca,'FontSize',font);

% exportgraphics(t,'myplot.png','BackgroundColor','none','Resolution',300)
end