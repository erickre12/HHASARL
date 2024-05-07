function [Cq,q,permuta]=Actions(Cruta,ruta,action,model,permuta)
        if action<=4
            a=permuta(1);
            permuta(1)=[];
            porce=round(model.n*0.20);
            A=model.d(a+1,2:model.SIZE);
            [~,indx]=sort(A);
            val=indx(2:porce+1);
            a=sort([a val(round(rand()*(length(val)-1))+1)]);
        elseif action>=5 && action<=8
            a=permuta(1);
            permuta(1)=[];
            porce=round(model.n*0.50);
            A=model.d(a+1,2:model.SIZE);
            [~,indx]=sort(A);
            val=indx(2:porce+1);
            a=sort([a val(round(rand()*(length(val)-1))+1)]);
        else
            a=permuta(1);
            permuta(1)=[];
            temp=ruta(ruta>0);
            temp(find(temp==a))=[];
        	a=sort([a temp(round(rand()*(length(temp)-1))+1)]);
        end
   	c=ismember(ruta,a);
	indexes=find(c);
 	Cc=ismember(Cruta,a);
	Cindexes=find(Cc);
    switch action      
        %IntraRoute Modificar la Cadena
        case 1  % Swap
            q=DoSwap(ruta,indexes(1),indexes(2));
            Cq=DoSwap(Cruta,Cindexes(1),Cindexes(2));
      	case 2  % Reversion  
            q=DoReversion(ruta,indexes(1),indexes(2));
            Cq=DoReversion(Cruta,Cindexes(1),Cindexes(2));
    	case 3  % 2OPT
            q=Do2Opt(ruta,indexes(1),indexes(2));
            Cq=Do2Opt(Cruta,Cindexes(1),Cindexes(2));
            if q(end)~=0
                q(end+1)=0;
                Cq(end+1)=0;
            end
     	case 4  % Insertion
            q=DoInsertion(ruta,indexes(1),indexes(2));
            Cq=DoInsertion(Cruta,Cindexes(1),Cindexes(2));
        case 5
             q=DoSwap(ruta,indexes(1),indexes(2));
            Cq=DoSwap(Cruta,Cindexes(1),Cindexes(2));
      	case 6  % Reversion  
            q=DoReversion(ruta,indexes(1),indexes(2));
            Cq=DoReversion(Cruta,Cindexes(1),Cindexes(2));
    	case 7  % 2OPT
            q=Do2Opt(ruta,indexes(1),indexes(2));
            Cq=Do2Opt(Cruta,Cindexes(1),Cindexes(2));
            if q(end)~=0
                q(end+1)=0;
                Cq(end+1)=0;
            end
     	case 8  % Insertion
            q=DoInsertion(ruta,indexes(1),indexes(2));
            Cq=DoInsertion(Cruta,Cindexes(1),Cindexes(2));
        case 9
             q=DoSwap(ruta,find(ruta==a(1)),find(ruta==a(2)));
            Cq=DoSwap(Cruta,Cindexes(1),Cindexes(2));
      	case 10  % Reversion  
            q=DoReversion(ruta,find(ruta==a(1)),find(ruta==a(2)));
            Cq=DoReversion(Cruta,find(Cruta==a(1)),find(Cruta==a(2)));
    	case 11  % 2OPT
            q=Do2Opt(ruta,find(ruta==a(1)),find(ruta==a(2)));
            Cq=Do2Opt(Cruta,find(Cruta==a(1)),find(Cruta==a(2)));
            if q(end)~=0
                q(end+1)=0;
                Cq(end+1)=0;
            end
     	case 12  % Insertion
            q=DoInsertion(ruta,find(ruta==a(1)),find(ruta==a(2))); 
            Cq=DoInsertion(Cruta,find(Cruta==a(1)),find(Cruta==a(2)));
        case 13
            va=round(model.n*0.3);
            v=randperm(model.n); 
            a=v(1:va);
            for l=1:length(a)
                u(l)=find(ruta==a(l));
            end
            [q,Cq]=DoDR(ruta,Cruta,u,0,model);
    end
end