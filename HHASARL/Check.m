function [flag1,vect,carga]=Check(ruta,model)
    MAX_CAPACITY=model.CAPACITY;
    cust_demand=model.DEMAND;
   	capacity_temp = 0;
    len=length(ruta);
    vect=[];
    carga=[];
    
    if ruta(1)~=0||ruta(end)~=0
        flag1 = 0; return
    end 
    
    for i=1:len
        if ruta(i)==0
            carga=[carga capacity_temp];
            capacity_temp = 0;
        end
        capacity_temp=capacity_temp+cust_demand(ruta(i)+1);
        if capacity_temp>MAX_CAPACITY
            vect=[vect i];
        end
    end
    if isempty(vect)
        flag1=1; % Cumple la restricción de carga (1)
    else
        flag1=0; % No cumple la restricción de carga (0)
    end  
end