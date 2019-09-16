function [CloseSrc, CloseDst] = FindTwoClosestPoint(src, dst)
    [srclen,~]= size(src);
    [dstlen,~]= size(dst);
    
    % merge to distance map
    k = srclen * dstlen;
    Distance = zeros(k,1);
    
    if k == 1
        CloseSrc = src(1,:);
        CloseDst = dst(1,:);
        return;
    end
    
    for i = 1:srclen 
        for j = 1:dstlen 
            blockNo = i-1;
            Distance(blockNo*dstlen + j) = GetDist(src(i,:), dst(j,:));
        end
    end
    
    [~, Idx] = min(Distance);
    IdxSrc = int32(ceil(Idx/dstlen));
    IdxDst = mod(Idx-1,dstlen)+1;
    
    CloseSrc = src(IdxSrc,:);
    CloseDst = dst(IdxDst,:);
end

function result = GetDist(first, second)
    result = sum((first - second).^2);
end
