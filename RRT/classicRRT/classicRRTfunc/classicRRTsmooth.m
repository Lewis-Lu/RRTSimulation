function smooth_vertices = classicRRTsmooth(map, vertices)
    smooth_vertices = double.empty(0,2);
    turning_vertice = 1;
    times = 1;
    smooth_vertices = [smooth_vertices; vertices(turning_vertice,:)];
    
    for i = 2 : length(vertices)
        if 0 == IsinFreeSpace(map, times, vertices(turning_vertice,:),vertices(i,:))
            turning_vertice = i - 1;
            times = 1;
            smooth_vertices = [smooth_vertices; vertices(turning_vertice,:)];
        end
        times = times + 1;
    end
end

function status = IsinFreeSpace(map, check_time, q_first, q_second)
    basic_check_param = 20;
    dist_delta = floor((q_second - q_first)/(check_time * basic_check_param));
    q_check = q_first;
    for i = 1:basic_check_param * check_time
        if map(q_check(2),q_check(1)) == 0
            status = 0;
            return;
        end
        q_check = q_check+dist_delta;
    end
    status = 1;
end