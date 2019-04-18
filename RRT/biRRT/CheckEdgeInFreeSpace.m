% state = CheckEdgeInFreeSpace(map, q1, q2)
function state = CheckEdgeInFreeSpace(map, q1, q2)
    v = q1 - q2;
    
    dist = norm(v);
    
    u = v/dist;
    
    delta = 5;
    
    checktime = dist/delta;
    
    q_check = q1;
    
    for i = 1:checktime
        if 0 == map(int32(q_check(2)), int32(q_check(1)))
           state = 0;
           return;
        end
        q_check = q_check + u*delta;
    end
    state = 1;
end