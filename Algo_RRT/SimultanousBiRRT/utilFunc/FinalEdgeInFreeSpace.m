function state = FinalEdgeInFreeSpace(map, newSrc, newDst)
    v = newSrc - newDst;
    
    distance = norm(v);
    
    u = v / distance;
    
    intermediatetime = distance / norm(u);
    
    delta = 5;
    
    checkPoint = newDst;
    for i = 1:intermediatetime
        if map(int32(checkPoint(2)), int32(checkPoint(1))) == 0
            state = 0;
            return;
        end
        checkPoint = checkPoint + u*delta;
    end
    state = 1;
end