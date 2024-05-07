function q=DoSwap(p,i1,i2)
    q=p;
    q([i1 i2])=p([i2 i1]);
end