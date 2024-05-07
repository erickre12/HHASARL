function q=DoReversion(p,i1,i2)
    q=p;
    if i1<i2
        q(i1:i2)=p(i2:-1:i1);
    else
        q(i1:-1:i2)=p(i2:i1);
    end
end