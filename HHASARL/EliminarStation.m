function [newsegment,newCsegment]=EliminarStation(segment,Csegment,x)
    a=randi(length(x));
    newsegment=segment;
    newsegment(x(a))=[];
    newCsegment=Csegment;
    newCsegment(x(a))=[];
end