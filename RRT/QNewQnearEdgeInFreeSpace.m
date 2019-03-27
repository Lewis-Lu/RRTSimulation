function status = QNewQnearEdgeInFreeSpace(map,q_near, q_new)
    % 0 --> Edge not in Free Space
    % 1 --> Edge in Free Space
    segment = 10;
    v = q_new - q_near;
    delta = int32(v/segment);
    q_test = int32(q_near);
    for iter = 1: segment
%         disp(q_test);
        q_test = int32(q_test + delta);
        if map(q_test(1), q_test(2)) == 0
            status = 0;
            return;
        end
    end
    status = 1;
end