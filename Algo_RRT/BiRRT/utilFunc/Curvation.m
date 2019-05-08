function [control_first, control_second] = Curvation(map, turning_vertices, index)
    delta = 15;
    direction_first = turning_vertices(index-1,:) - turning_vertices(index,:);
    dist_first = norm(turning_vertices(index-1,:) - turning_vertices(index,:));

    direction_second = turning_vertices(index+1,:) - turning_vertices(index,:);
    dist_second = norm(turning_vertices(index+1,:) - turning_vertices(index,:));

    u_first = direction_first ./ dist_first;
    u_second = direction_second ./ dist_second;

    control_first = floor(turning_vertices(index,:) + delta .* u_first);
    control_second = floor(turning_vertices(index,:) + delta .* u_second);

    while QnewQnearInFreeSpace(map, control_first, control_second) == 0
        delta = delta - 5;
        direction_first = turning_vertices(index-1,:) - turning_vertices(index,:);
        dist_first = norm(turning_vertices(index-1,:) - turning_vertices(index,:));
        
        direction_second = turning_vertices(index+1,:) - turning_vertices(index,:);
        dist_second = norm(turning_vertices(index+1,:) - turning_vertices(index,:));
        
        u_first = direction_first ./ dist_first;
        u_second = direction_second ./ dist_second;
        
        control_first = floor(turning_vertices(index,:) + delta .* u_first);
        control_second = floor(turning_vertices(index,:) + delta .* u_second);
        
    end
end