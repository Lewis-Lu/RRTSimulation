% smooth_vertices = Smooth(map, op_vertices)
function smooth_vertices = Smooth(map, op_vertices)
    smooth_vertices = double.empty(0,2);
    turningPoint_index = 1;
    
    % add q_start into smooth_vertices
    smooth_vertices = [smooth_vertices; op_vertices(turningPoint_index,:)];
    
    for i = 2:length(op_vertices)
        if 0 == IsinFreeSpace(map, op_vertices(turningPoint_index,:), op_vertices(i,:))
            turningPoint_index = i-1;
            smooth_vertices = [smooth_vertices; op_vertices(turningPoint_index,:)];
        end
    end
    if i == length(op_vertices)
        smooth_vertices = [smooth_vertices; op_vertices(end,:)];
    end
end

function status = IsinFreeSpace(map, q_first, q_second)
    v = q_second - q_first;
    
    distance = norm(v);
    
    u = v / distance;
    
    % sampling interval
    delta = 5;
    
    intermediatePointCount = distance / delta;
    
    q_check = q_first;
    
    for i = 1 : intermediatePointCount
        if map(int32(q_check(2)),int32(q_check(1))) == 0
            status = 0;
            return;
        end
        q_check = q_check + (delta * u);
    end
    
    status = 1;

end
