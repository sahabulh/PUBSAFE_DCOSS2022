a = [1:size(USER,1) 1:size(UAV,1)]'; b = num2str(a); c = cellstr(b);
dx = 1; dy = 1;
scatter3(USER(:,1),USER(:,2),USER(:,3),'b');
text(USER(:,1)+dx, USER(:,2)+dy,USER(:,3),c(1:size(USER,1)));
hold on;
scatter3(UAV(:,1),UAV(:,2),UAV(:,3),'r');
text(UAV(:,1)+dx, UAV(:,2)+dy,UAV(:,3),c(size(USER,1)+1:size(USER,1)+size(UAV,1)));
hold off;