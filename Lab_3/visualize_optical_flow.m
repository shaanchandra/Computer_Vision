function visualize_optical_flow(img, v, XY, grid)

tmp = XY(:,1);
XY(:,1) = XY(:,2);
XY(:,2) = tmp;
XY = reshape(XY, [], 2);

imshow(img);
hold on; %enable plotting overwrite
% Plotting grid
if grid
    [h,w,~] = size(img);
    for k = 1:15:h
        x = [1 w];
        y = [k k];
        plot(x,y,'Color','w','LineStyle','-.');
        y = [1 h];
        x = [k k];
        plot(x,y,'Color','w','LineStyle','-.');
    end
end
% Set 5th parameter to 1 if arrows should be normalized (assumed when
% setting to 1)
if grid
    quiver(XY(:, 1), XY(:, 2), squeeze(v(:,1)), squeeze(v(:,2)),'color',[1 0.0 0.0],'linewidth',1.5);
else
    quiver(XY(:, 1), XY(:, 2), squeeze(v(:,1)), squeeze(v(:,2)), 0,'color',[1 0.0 0.0],'linewidth',1.5);
end
[pt,~] = size(XY);
for i=1:pt
    plot(XY(i,1),XY(i,2),'o','Color',[0.0 0.0 0.0],'MarkerSize',4,'MarkerFaceColor',[0.0 0.0 0.0]);
end
end

