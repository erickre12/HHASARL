function [ruta,rutaC]=AddStation(ruta,model)
estaciones=check_station(ruta,model);
rutaC=ruta;
cont=1;
for j=1:length(estaciones)
    n=estaciones(j)+cont-1;
    if n~=length(ruta)
        if ruta(n+1)~=-1 && ruta(n)~=-1
            ruta=[ruta(1:n) -1 ruta(n+1:end)];
         	station=nearstation(zeros(model.STATIONS,1),rutaC(n)+1,rutaC(n+1)+1,model.d,model.SIZE);
          	rutaC=[rutaC(1:n) station+model.SIZE-1 rutaC(n+1:end)];
          	cont=cont+1;
        end
    else
      	if ruta(n)~=-1
            ruta=[ruta(1:n) -1 ruta(n+1:end)];
         	station=nearstation(zeros(model.STATIONS,1),rutaC(n)+1,rutaC(n+1)+1,model.d,model.SIZE);
            rutaC=[rutaC(1:n) station+model.SIZE-1 rutaC(n+1:end)];
        	cont=cont+1;
        end
    end
end
end