function t = graph_RN5(I,yl)
font = 24;

figure(1)
t = tiledlayout(1,1,'TileSpacing','Compact','Padding','Compact');

nexttile
x = 1:length(I);
plot(x,I(1,:),'bo-','Linewidth',3);
hold on;
plot(x,I(2,:),'ro-','Linewidth',3);
hold on;
plot(x,I(3,:),'go-','Linewidth',3);
hold on;
plot(x,I(4,:),'ko-','Linewidth',3);
hold on;
plot(x,I(5,:),'mo-','Linewidth',3);
hold off;
xlabel("Users");
ylabel(yl);
xlim([1 length(I)])
set(gca,'FontSize',font);

% exportgraphics(t,'myplot.png','BackgroundColor','none','Resolution',300)
end