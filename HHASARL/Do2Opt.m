function q=Do2Opt(p,i1,i2)
    if i1<i2
        q=p([1:i1-1 i2:end i1:i2-1]);
    else
        q=p([1:i2-1 i1:end i2:i1-1]);
    end
end