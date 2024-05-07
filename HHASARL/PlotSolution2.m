function PlotSolution2(sol,model)
    subplot(1,3,1);
    xmin=model.xmin;
    xmax=model.xmax;
    ymin=model.ymin;
    ymax=model.ymax;
    
    tour=sol.CRoute+1;
    
    tour=[tour tour(1)];
    
    plot(model.x(tour),model.y(tour),'k-o',...
        'MarkerSize',10,...
        'MarkerFaceColor','b',...
        'LineWidth',1.5);
    hold on;
    plot(model.x(1),model.y(1),'k-o','MarkerSize',10,'MarkerFaceColor','r', 'LineWidth',1.5)
    plot(model.x(model.SIZE+1:end),model.y(model.SIZE+1:end),'s','MarkerSize',15,'MarkerFaceColor','black','MarkerEdgeColor','black')
    hold off;
%     plot(node_list(1,1),node_list(1,2),'.','MarkerSize',14,'MarkerEdgeColor','red')
% 	plot(node_list(2:problem_size,1),node_list(2:problem_size,2),'.','MarkerSize',10,'MarkerEdgeColor','blue')
%     plot(node_list(problem_size+1:ACTUAL_PROBLEM_SIZE,1),node_list(problem_size+1:ACTUAL_PROBLEM_SIZE,2),'s','MarkerSize',15,'MarkerFaceColor','black','MarkerEdgeColor','black')
    
    xlabel('x');
    ylabel('y');
    
    %axis equal;
    grid on;
    
	alpha = 0.1;
	
    dx = xmax - xmin;
    xmin = floor((xmin - alpha*dx)/10)*10;
    xmax = ceil((xmax + alpha*dx)/10)*10;
    xlim([xmin xmax]);
    
    dy = ymax - ymin;
    ymin = floor((ymin - alpha*dy)/10)*10;
    ymax = ceil((ymax + alpha*dy)/10)*10;
    ylim([ymin ymax]);

end