
function model=Model(name)
    %filename = 'E-n22-k4.txt';
    %filename = 'E-n101-k8.txt';
    %filename = 'E-n76-k7.txt';
    %filename = 'E-n23-k3.txt';
    %filename = 'E-n30-k3.txt';
    %filename = 'E-n33-k4.txt';
    %filename = 'E-n51-k5.txt';
    filename=name;
%     filename = 'E-n22-k4.txt';  % Chido 384.6781 0
%     filename = 'E-n23-k3.txt';  % Chido 571.9474 0
%     filename = 'E-n30-k3.txt';  % Chido 509.4704 0
%     filename = 'E-n33-k4.txt';
    fileID = fopen(filename);
    C = textscan(fileID,'%s %s %s');
    fclose(fileID);

    %% Parametros
    %Obtener Variables del .txt
    
    problem_size=str2double(C{1,2}{find(strcmp(C{1,1},'DIMENSION:')),1});
    NUM_OF_STATIONS=str2double(C{1,2}{find(strcmp(C{1,1},'STATIONS:')),1});
    BATTERY_CAPACITY=str2double(C{1,2}{find(strcmp(C{1,1},'ENERGY_CAPACITY:')),1});
    MAX_CAPACITY=str2double(C{1,2}{find(strcmp(C{1,1},'CAPACITY:')),1});
    MIN_VEHICLES=str2double(C{1,2}{find(strcmp(C{1,1},'VEHICLES:')),1});
    energy_consumption=str2double(C{1,2}{find(strcmp(C{1,1},'ENERGY_CONSUMPTION:')),1});
    OPTIMUM=str2double(C{1,2}{find(strcmp(C{1,1},'OPTIMAL_VALUE:')),1});

    DEPOT=1;
    NUM_OF_CUSTOMERS = problem_size - 1;
    ACTUAL_PROBLEM_SIZE = problem_size + NUM_OF_STATIONS;
    MAX_TRIALS=20;
    CHAR_LEN=100;
    TERMINATION=25000*ACTUAL_PROBLEM_SIZE;

    node_list=zeros(ACTUAL_PROBLEM_SIZE,2); % Inicializacion de los nodos de coordenadas
    index=find(strcmp(C{1,1}, 'NODE_COORD_SECTION'));
    for i=1:ACTUAL_PROBLEM_SIZE
        node_list(i,1)=str2double(C{1,2}{i+index,1});
        node_list(i,2)=str2double(C{1,3}{i+index,1});
    end
    
    x=node_list(1:ACTUAL_PROBLEM_SIZE,1)';
    y=node_list(1:ACTUAL_PROBLEM_SIZE,2)';
    
    
    index=find(strcmp(C{1,1}, 'DEMAND_SECTION')); % Inicializacion de la demanda
    cust_demand=zeros(ACTUAL_PROBLEM_SIZE,1);
    charging_station=ones(ACTUAL_PROBLEM_SIZE,1);

    for i=1:problem_size
        cust_demand(i,1)=str2double(C{1,2}{i+index,1});
        charging_station(i,1)=0;
    end
    
    d=zeros(ACTUAL_PROBLEM_SIZE,ACTUAL_PROBLEM_SIZE);
    
    for i=1:ACTUAL_PROBLEM_SIZE
        for j=i:ACTUAL_PROBLEM_SIZE
         	%d(i,j)= sqrt((node_list(i,1)-node_list(j,1))^2 + (node_list(i,2)-node_list(j,2))^2);
            %d(i,j)=round(d(i,j)*100)/100;
            
            xd=node_list(i,1)-node_list(j,1);
            yd=node_list(i,2)-node_list(j,2);
            d(i,j) = sqrt(xd*xd + yd*yd);
            %d(i,j)=floor(d(i,j)*10)/10;
        	d(j,i)=d(i,j);
        end
    end

    xmin=min(x);
    xmax=max(x);
    
    ymin=min(y);
    ymax=max(y);
    
    model.n=NUM_OF_CUSTOMERS;
    model.x=x;
    model.y=y;
    model.d=d;
    model.MaxIter=TERMINATION;
    model.VEHICLES=MIN_VEHICLES;
    model.CAPACITY=MAX_CAPACITY;
    model.DEMAND=cust_demand;
    model.ENERGY=BATTERY_CAPACITY;
    model.STATIONS=NUM_OF_STATIONS;
    model.CONSUMPTION=energy_consumption;
    model.SIZE=problem_size;
    model.xmin=xmin;
    model.xmax=xmax;
    model.ymin=ymin;
    model.ymax=ymax;
    model.charging=charging_station;
end