% [status q_near = 1/ q_new = 2, touchedpoint] = QGoalTouched(map, q_new, q_near, q_goal) 
function [status, touchedpoint] = QGoalTouched(map, q_new, q_near, q_goal)
    QnewQnearDist = norm(q_new - q_near);
    QGoalQnearDist = norm(q_goal - q_near);
    if QnewQnearDist > QGoalQnearDist % q_goal in the range
        if QNewQNearEdgeInFreeSpace(map, q_near, q_goal)
            status = 1;
            touchedpoint = 1;
            return;
        elseif QNewQNearEdgeInFreeSpace(map, q_new, q_goal)
            status = 1;
            touchedpoint = 2;
            return;
        else
            status = 0;
            return;
        end
    end
    status = 0;
end