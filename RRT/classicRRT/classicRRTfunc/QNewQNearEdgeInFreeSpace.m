% 0 --> Edge not in Free Space / 1 --> Edge in Free Space
function status = QNewQNearEdgeInFreeSpace(map, q_near, q_new)
    % in map, 1 is freespace, 0 is not.
    CheckPointNum = 10;
    delta = floor((q_new - q_near) / CheckPointNum);
    q_check = q_near;
    for i = 1 : CheckPointNum
        if map(q_check(2), q_check(1)) == 0
            status = 0;
            return;
        end
        q_check = q_check + delta;
    end
    status = 1;
end