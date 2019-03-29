function checkParameters(map, q_start, q_goal, k, delta_q, p)
    [mapHeight, mapWidth] = size(map);
    if mapHeight < 1 || mapWidth < 1
        error('Please Provide 2D map.');
    end
    
    [x, y] = size(q_start);
    if x ~= 1 || y ~= 2
        error('Start point dimension error.');
    elseif q_start(1) < 0 || q_start(1) > mapWidth || q_start(2) < 0 || q_start(2) > mapHeight
        error('Start Point out of map.');
    end
    
    [x, y] = size(q_goal);
    if x ~= 1 || y ~= 2
        error('Goal point dimension error.');
    elseif q_goal(1) < 0 || q_goal(1)> mapWidth || q_goal(2) < 0 || q_goal(2) > mapHeight
        error('Goal Point out of map.');
    end
    
    if k < 1
        error('Iteration time should be positive.');
    end
    
    if delta_q < 1
        error('Step Size delta_q distance should be positive.');
    end
    
    if p < 0 || p > 1
        error('Probability should between 0 and 1.');
    end
end
