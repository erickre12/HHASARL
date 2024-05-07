function q=DoInsertion(p,i1,i2)
    if i1<i2
        q=p([1:i1-1 i1+1:i2 i1 i2+1:end]);
    else
        q=p([1:i2 i1 i2+1:i1-1 i1+1:end]);
    end
end