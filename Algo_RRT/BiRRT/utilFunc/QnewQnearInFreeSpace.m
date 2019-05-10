% state = QnewQnearInFreeSpace(map, q1, q2)/q1 = q_near/q2 = q_new
function state = QnewQnearInFreeSpace(map, q1, q2)
    [mapHeight, mapWidth] = size(map);
    v = q2 - q1;
    checktime = 10;
    delta = v/10;
    q_check = q1;
    for i = 1:checktime
        checkPoint = int32(q_check);
        if checkPoint(1) < 1 || checkPoint(1) > mapWidth ||...
                checkPoint(2) < 1 || checkPoint(2) > mapHeight
            state = 0;
            return;
        end
        if 0 == map(int32(q_check(2)), int32(q_check(1)))
           state = 0;
           return;
        end
        q_check = q_check + delta;
    end
    state = 1;
end