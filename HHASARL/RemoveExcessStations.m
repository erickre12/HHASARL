function [rutaP,rutaR]=RemoveExcessStations(rutaP,rutaR)
  	vec=[];
   	for i=1:length(rutaP)-2
        if rutaP(i)==0 && rutaP(i+1)==-1 && rutaP(i+2)==0
            vec=[vec i+1];
        end
    end
    rutaP(vec)=[];
    rutaR(vec)=[];
end