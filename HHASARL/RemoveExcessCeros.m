function [rutaP,rutaR,rutaC]=RemoveExcessCeros(rutaP,rutaR,rutaC)
    vec1=[];
    vec2=[];
    for i=1:length(rutaP)-1
        if rutaP(i+1)==0 && rutaP(i)==0
            vec1=[vec1 i];
        end
    end
    rutaP(vec1)=[];
    for i=1:length(rutaR)-1
        if rutaR(i+1)==0 && rutaR(i)==0
        	vec2=[vec2 i];
        end
    end
    rutaR(vec2)=[];
    rutaC(vec2)=[];
end