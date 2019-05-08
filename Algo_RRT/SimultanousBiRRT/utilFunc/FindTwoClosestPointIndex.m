function [srcidx, dstidx] = FindTwoClosestPointIndex(src, dst)
    [srclen,~]= size(src);
    [dstlen,~]= size(dst);
    k = srclen * dstlen;
    
    res = double.empty(0, 2);
    dist = zeros(k,1);
    
    for i = 1 : srclen
        tmp = (dst - src(i,:)).^2;
        res = [res; tmp];
    end
    
    dist = res(:,1) + res(:,2);
    
    [~, idx] = min(dist);

    
    if srclen == 1
       srcidx = 1;
       dstidx = idx;
    elseif dstlen == 1
        srcidx = idx;
        dstidx = 1;
    else
        dstidx = int32(mod(idx,dstlen));
        if dstidx == 0
            dstidx = 1;
        end
        srcidx = int32((idx-dstidx)/srclen);
    end
    
end
