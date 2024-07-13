function t = graph_RN2(I,D,yl)
font = 24;

figure(1)
t = tiledlayout(1,3,'TileSpacing','Compact','Padding','Compact');

nexttile
x = 1:length(I(D==1));
plot(x,I(D==1),'bo-','Linewidth',3);
xlabel("Users (UAV 1)");
ylabel(yl);
xlim([1 length(I(D==1))])
set(gca,'FontSize',font);

nexttile
x = 1:length(I(D==2));
plot(x,I(D==2),'bo-','Linewidth',3);
xlabel("Users (UAV 2)");
ylabel(yl);
xlim([1 length(I(D==2))])
set(gca,'FontSize',font);

nexttile
x = 1:length(I(D==3));
plot(x,I(D==3),'bo-','Linewidth',3);
xlabel("Users (UAV 3)");
ylabel(yl);
xlim([1 length(I(D==3))])
set(gca,'FontSize',font);

% exportgraphics(t,'myplot.png','BackgroundColor','none','Resolution',300)
end