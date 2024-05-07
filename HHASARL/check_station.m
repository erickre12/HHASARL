function newstation=check_station(rutamodif,model)
    newstation=[];
    energy_temp = model.ENERGY; 
    len=length(rutamodif);
    for i=1:len-1
        from=rutamodif(i);
        to=rutamodif(i+1);
        energy=model.CONSUMPTION*model.d(from+1,to+1);
     	energy_temp=energy_temp-energy;
        if energy_temp < 0
            if from~=0 || from<model.SIZE
                newstation=[newstation i-1];
                energy_temp = model.ENERGY;
            end
        end
        if to==0 || to>=model.SIZE
            energy_temp = model.ENERGY;
        end
    end
end

