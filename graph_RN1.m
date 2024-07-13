function t = graph_RN1(I,C,yl)
font = 24;

figure(1)
t = tiledlayout(1,1,'TileSpacing','Compact','Padding','Compact');

nexttile
x = 1:length(I);
plot(x,I,'bo-','Linewidth',3);
hold on;
plot(x,C,'ro-','Linewidth',3);
hold off;

xlabel("Users");
ylabel(yl);
xlim([1 length(I)])
legend(["Incomplete","Complete"],'Location','northwest');
set(gca,'FontSize',font);

% exportgraphics(t,'myplot.png','BackgroundColor','none','Resolution',300)
end