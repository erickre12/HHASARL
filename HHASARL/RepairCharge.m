function [newrutaP,newrutaC,newrutaR,flag1,limit,carga,trash]=RepairCharge(rutaP,rutaC,rutaR,limit,carga,model)
    trash=0;
    i=1;
    z=find(rutaP==0);
    repair=[];
    vec=[];
    client=rutaP(limit(i));
    c=model.DEMAND(client+1); 
    for k=2:length(carga)
        if carga(k)+c<=model.CAPACITY
            repair=[repair k];
            vec=[vec rutaP(z(k-1)+1:z(k)-1)];
        end
    end    
    if ~isempty(repair)
        A=model.d(client+1,vec+1);
        [~,pos]=min(A);
        %Eliminar el cliente
        rutaP(limit(i))=[];
        indx=find(rutaC==client);
        rutaC(indx)=[];
        rutaR(indx)=[];
        %Agregamos el cliente en su nueva posicion
        i1=find(rutaP==vec(pos));
        i2=find(rutaC==vec(pos));
        newrutaP=[rutaP(1:i1) client rutaP(i1+1:end)];
        newrutaR=[rutaR(1:i2) client rutaR(i2+1:end)];
        newrutaC=[rutaC(1:i2) client rutaC(i2+1:end)];
      	[newrutaP,newrutaR,newrutaC]=RemoveExcessCeros(newrutaP,newrutaR,newrutaC);
     	[flag1,limit,carga]=Check(newrutaP,model);
    else
        newrutaP=rutaP;
        newrutaR=rutaR;
        newrutaC=rutaC;
        trash=1;
        flag1=0;
    end
    [newrutaR,newrutaC]=RemoveExcess(newrutaR,newrutaC);

end