function status = QGoalTouched(map, q_new, q_goal)
    % map, q_new, q_goal
    if QNewQnearEdgeInFreeSpace(map, q_new, q_goal)
        status = 1;
    end
    status = 0;
end