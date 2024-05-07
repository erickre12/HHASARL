function [rutaP,rutaR]=RemoveExcess(rutaP,rutaR)
    vec=[];
    for i=1:length(rutaP)-1
        if rutaP(i+1)==-1 && rutaP(i)==-1
            vec=[vec i];
        end
    end
  	rutaP(vec)=[];
   	rutaR(vec)=[];
end