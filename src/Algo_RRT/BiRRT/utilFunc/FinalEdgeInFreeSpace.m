function state = FinalEdgeInFreeSpace(map, newSrc, newDst)
    [mapHeight, mapWidth] = size(map);
    
    Srccheck = int32(newSrc);
    Dstcheck = int32(newDst);
    
    if Srccheck(1) < 1 || Srccheck(1) > mapWidth || Srccheck(2) < 1 || Srccheck(2) > mapHeight || ...
            Dstcheck(1) < 1 || Dstcheck(1) > mapWidth || Dstcheck(2) < 1 || Dstcheck(2) > mapHeight
        state = 0;
        return;
    end
    v = newSrc - newDst;
    
    distance = norm(v);
    
    u = v / distance;
    
    intermediatetime = distance / norm(u);
    
    delta = 5;
    
    checkPoint = newDst;
    for i = 1:intermediatetime
        q_check = int32(checkPoint);
        if q_check(1) < 1 || q_check(1) > mapWidth ||...
                q_check(2) < 1 || q_check(2) > mapHeight
            state = 0;
            return;
        end
        if map(int32(checkPoint(2)), int32(checkPoint(1))) == 0
            state = 0;
            return;
        end
        checkPoint = checkPoint + u*delta;
    end
    state = 1;
end