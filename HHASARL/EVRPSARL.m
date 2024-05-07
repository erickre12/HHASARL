function [BestSol,minCost,flagggg,MemoryHeuristicsSu,MemoryHeuristicsSe]=EVRPSARL(model,RL, print, draw)

% RL:
% 0 Rand
% 1 Epsilon-greedy
% 2 Thomson Sampling
% 3 Upper Confidence Bound 1

%% SA Parameters
r = 0.99; 
T0=30;   
Ts=0.001;
T = T0;

%% MAB Parameters
iter=model.SIZE*40;
it=0;
nbandits=8; % Number of heuristics
% Reset probabilities of actions
Suc=zeros(1,nbandits);
Fail=zeros(1,nbandits);
theta=zeros(1,nbandits);
Selected=zeros(1,nbandits);
costArray=zeros(1,1000);

if draw == 1
    set(gcf,'unit','normalized','position',[0,0.2,0.8,0.7]);
    im = {}; jj = 1;
    [im{jj},map]=frame2im(getframe);
end

%% Parameters
x1=0;
x2=90;

y1=1;
y2=0.05;
m=(y2-y1)/(x2-x1);
b=y2-(m*x2);

mov1=1;
mov2=0.9;

m3=(mov2-mov1)/(x2-x1);
b3=mov2-(m3*x2);

% Initialization
sol.Position=[];
sol.Position=randperm(model.n);
sol.Position=AddDeposit(sol.Position,model);

[sol.Route,sol.CRoute]=AddStation(sol.Position,model);
sol.Length=inf;
BestSol=sol;
cnt = 1;
minCost = sol.Length;

flagggg=0;
enfriar=0;
permuta=0;
while(T > Ts)
    % Evaluate function accesses
    if it>=model.MaxIter
        if draw == 1
            [temp,map] = rgb2ind(im{1},65536);
            jjend=jj-1;
            for jj=1:jjend
                gifim(:,:,1,jj)=rgb2ind(im{jj},map);
            end
            imwrite(gifim,map,'E22.gif')
        end
        flagggg=1;
        MemoryHeuristicsSe=num2cell(MemorySe);
        MemoryHeuristicsSu=num2cell(MemorySu);
        break; 
    end
    
    % Multi-Armed Bandit (MAB)
    % Selection of heuristics
    for k=1:iter
        switch RL
            case 0
                action=round((nbandits-1)*rand +1);
            case 1
                if rand()<0.1
                    action=round(rand()*(nbandits-1)+1);
                else
                    [~,action]= max(Suc); 
                end
            case 2
                for nb=1:nbandits
                    theta(nb) = betarand(Suc(nb)+1,Fail(nb)+1); % Actualizar probabilidades de las acciones
                end
                [~,action]= max(theta); 
            case 3
                if k<=nbandits
                    action=k;
                else
                    rest=Suc./Selected;
                    rhat=rest+sqrt(2*log(k)./(Selected));
                    [~,action]= max(rhat);
                end
        end
        Selected(action)=Selected(action)+1;

      	go=1;
        flagg=1;
        while flagg==1
            if ~isempty(permuta)
                permuta=randperm(model.n);
            end
            [newsol.CRoute,newsol.Route,permuta]=Actions(sol.CRoute,sol.Route,action,model,permuta);
            newsol.Position=newsol.Route(newsol.Route>=0);
            [newsol.Route,newsol.CRoute]=RemoveExcessStations(newsol.Route,newsol.CRoute);
        	[newsol.Route,newsol.CRoute]=RemoveExcess(newsol.Route,newsol.CRoute);
        	[newsol.Position,newsol.Route,newsol.CRoute]=RemoveExcessCeros(newsol.Position,newsol.Route,newsol.CRoute);
            [flag1,limit,carga]=Check(newsol.Position,model);
            
          	if flag1==1
                go=1;
              	flagg=0;
            else
                while flag1==0
                    [newsol.Position,newsol.CRoute,newsol.Route,flag1,limit,carga,trash]=RepairCharge(newsol.Position,newsol.CRoute,newsol.Route,limit,carga,model);
                    if flag1==1
                        go=1;
                        flagg=0;
                    end
                    if trash==1
                        go=0;
                        flagg=0;
                        break;
                    end
                end
            end
        end
        [newsol.Route,newsol.CRoute]=RemoveExcess(newsol.Route,newsol.CRoute);
        
        if go==1
            bb=m3*(it/model.MaxIter*100)+b3;        	
            [newsol.Route,newsol.CRoute,newsol.Length,it]=Rutas(newsol.Route,newsol.CRoute,model,it,bb);
            newsol.Position=newsol.Route(newsol.Route>=0);
            [newsol.Route,newsol.CRoute]=RemoveExcessStations(newsol.Route,newsol.CRoute);
      
            delta = newsol.Length-sol.Length;
    
            if(delta <= 0)
                sol=newsol;
             	Suc(action)=Suc(action)+1;
            else
                p=exp(-delta/T);
                if rand() <=p 
                    sol=newsol;
                end
            end
        end
    end
    
	%Reset probabilities of actions
    MemorySu(cnt,:) = Suc;
	MemorySe(cnt,:) = Selected;
    Suc=zeros(1,nbandits);
    theta=zeros(1,nbandits);
	Selected=zeros(1,nbandits);

    costArray(cnt) = sol.Length;
    if sol.Length<minCost
    	BestSol=sol;
       	minCost = sol.Length;
        enfriar=0;
    else
        enfriar=enfriar+1;
    end
    Costmin(cnt) = minCost;
    
    if enfriar < 20
            T = T*r; %  annealing
    else
       	enfriar=0;
        if T<300000 && it<=0.9*model.MaxIter
            c=m*(it/model.MaxIter*100)+b;
            T = T+c;
        end
    end
    
    if print == 1
        disp([' Iteration ' num2str(cnt) ': BestCost = ' num2str(minCost) ': CurrentCost = ' num2str(sol.Length) ' T = ' num2str(T) ': Percentage = ' num2str(it/model.MaxIter*100)]);
    end
    cnt = cnt+1;
   	BestSol.cost=costArray;
    BestSol.mincost=Costmin;
    
    if draw == 1
        figure(1);
        PlotSolution2(sol,model)
        subplot(1,3,2)
        plot(costArray);
        PlotSolution3(BestSol,model)
        [im{jj},map]=frame2im(getframe(figure(1)));
        jj = jj+1;
    end
end