% state = QnewQnearInFreeSpace(map, q1, q2)/q1 = q_near/q2 = q_new
function state = QnewQnearInFreeSpace(map, q1, q2)
    v = q2 - q1;
    checktime = 10;
    delta = v/10;
    q_check = q1;
    for i = 1:checktime
        if 0 == map(int32(q_check(2)), int32(q_check(1)))
           state = 0;
           return;
        end
        q_check = q_check + delta;
    end
    state = 1;
end