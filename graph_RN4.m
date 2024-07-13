function t = graph_RN4(name,dname,y1)
font = 24;
data = load(name);
G = data.(dname);
S = data.S(data.idx);
X = [mean(G(S==0.9)) mean(G(S==0.7)) mean(G(S==0.3))];

figure(1)
t = tiledlayout(1,1,'TileSpacing','Compact','Padding','Compact');

nexttile
yyaxis left;
plot([0.9 0.7 0.3],'Linewidth',3);
ylabel("Importance");
hold on;
yyaxis right;
plot(X,'Linewidth',3);
ylabel(y1);
hold off;

xlabel("User types");
set(gca,'FontSize',font);
set(gca,'xtick',1:3,'xticklabel',{'Fire Dept','Ambulance','Police'});

% exportgraphics(t,'myplot.png','BackgroundColor','none','Resolution',300)
end