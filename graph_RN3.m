function t = graph_RN3(name,dname,y1)
font = 24;
data = load(name);
T = data.(dname);

figure(1)
t = tiledlayout(1,1,'TileSpacing','Compact','Padding','Compact');
[~,idx] = sort(data.type);

nexttile
x = 1:ceil(data.ite);
tf = data.et/data.ite;
x = x.*tf;
plot(x,movmean(T(1:data.ite,idx(20)),100),'b','Linewidth',3);
hold on;
plot(x,movmean(T(1:data.ite,idx(11)),100),'r','Linewidth',3);
hold on;
plot(x,movmean(T(1:data.ite,idx(3)),100),'g','Linewidth',3);
hold off;

xlabel("Execution time (s)");
ylabel(y1);
xlim([0 max(x)])
legend(["Best user","Average user","Worst user"],'Location','northwest');
set(gca,'FontSize',font);

% exportgraphics(t,'myplot.png','BackgroundColor','none','Resolution',300)
end