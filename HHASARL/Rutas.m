function [AdjRoute,AdjCRoute,RouteFitness,it]=Rutas(route,Croute,model,it,bb)
    P(1)=0.0;   % Probabilidad Insertar
    P(2)=0.6;   % Probabilidad Mover
    P(3)=0.4;   % Probabilidad Eliminar
    AdjRoute=0;
    AdjCRoute=0;
   	zer=find(route==0);
    
    asd=0;
   	for g=1:length(zer)-1
        temp=route(zer(g):zer(g+1));
        Ctemp=Croute(zer(g):zer(g+1));
        estaciones=check_station(Ctemp,model);
        if isempty(estaciones)
            if rand()>bb
                ii=RouletteWheelSelection(P);
                switch ii
                    case 1
                        acc=1;
                        cont=1;
                        sze=length(temp)-1;
                    	vep=randperm(sze);
                        while acc==1
                            n=vep(cont);
                            if temp(n+1)~=-1 && temp(n)~=-1
                                temp=[temp(1:n) -1 temp(n+1:end)];
                                station=nearstation(zeros(model.STATIONS,1),Ctemp(n)+1,Ctemp(n+1)+1,model.d,model.SIZE);
                                Ctemp=[Ctemp(1:n) station+model.SIZE-1 Ctemp(n+1:end)];
                                acc=0;
                            else
                                cont=cont+1;
                            end
                            if cont==length(vep)
                                acc=0;
                            end
                        end
                    case 2 
                        x=find(temp==-1);
                        if ~isempty(x)
                            sze=length(x);
                            vep=randperm(sze);
                            for ee=1:1
                                a=vep(ee);
                                t=temp;
                                Ct=Ctemp;
                               	t(x(a))=[];
                                Ct(x(a))=[];
                                sz=length(t)-1;
                              	vep2=randperm(sz);
                                acc2=1;
                                cont=1;
                                while acc2==1
                                    n=vep2(cont);
                                    if t(n+1)~=-1 && t(n)~=-1 && n~=x(a)-1
                                        t=[t(1:n) -1 t(n+1:end)];
                                        station=nearstation(zeros(model.STATIONS,1),Ct(n)+1,Ct(n+1)+1,model.d,model.SIZE);
                                        Ct=[Ct(1:n) station+model.SIZE-1 Ct(n+1:end)];
                                        acc2=0;
                                    else
                                        cont=cont+1;
                                    end
                                    if cont==length(vep)+1
                                        acc2=0;
                                    end
                                end
                                flag=check_station(Ct,model);
                                if isempty(flag)
                                    temp=t;
                                    Ctemp=Ct;
                                    break;
                                end
                            end
                        end
                    case 3
                        x=find(temp==-1);
                        if ~isempty(x)
                            for k=1:1
                                [t,Ct]=EliminarStation(temp,Ctemp,x);
                                flag=check_station(Ct,model);
                                if isempty(flag)
                                    temp=t;
                                    Ctemp=Ct;
                                    break; 
                                end
                            end
                        end
                end
            end
        else
         	cont=1;
            for j=1:length(estaciones)
                n=estaciones(j)+cont-1;
              	if temp(n+1)~=-1 && temp(n)~=-1
                    temp=[temp(1:n) -1 temp(n+1:end)];
                    station=nearstation(zeros(model.STATIONS,1),Ctemp(n)+1,Ctemp(n+1)+1,model.d,model.SIZE);
                    Ctemp=[Ctemp(1:n) station+model.SIZE-1 Ctemp(n+1:end)];
                    cont=cont+1;
                else
                    asd=asd+1;
                end
            end
        end
      	AdjRoute=[AdjRoute temp(2:end)];
        AdjCRoute=[AdjCRoute Ctemp(2:end)];
    end
	RouteFitness=fitness_evaluation(AdjCRoute,model.d);
    it=it+1;
end