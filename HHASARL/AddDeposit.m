function ruta=AddDeposit(position,model)
    MAX_CAPACITY=model.CAPACITY;
    cust_demand=model.DEMAND;
   	capacity_temp = 0;
    ruta=0;
    
    for i=1:length(position)
        if (capacity_temp+cust_demand(position(i)+1) <= MAX_CAPACITY)
            capacity_temp=capacity_temp+cust_demand(position(i)+1);
            ruta=[ruta position(i)];
        else
            capacity_temp=cust_demand(position(i)+1);
            ruta=[ruta 0 position(i)];
        end
    end
    ruta=[ruta 0];
end