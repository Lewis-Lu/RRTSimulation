
function [result, time, vertices, edge] = classicRRT(map, q_start, q_goal, p, delta_q)

addpath(genpath('util'));
addpath(genpath('utilEnv'));

k = 10000;

edge = double.empty(0,2);
vertices = double.empty(0,2);
vertices = q_start;

[mapHeight, mapWidth] = size(map);

if map(int32(q_start(2)),int32(q_start(1))) == 0
    disp('Start Point in obstacle region.\n failed.');
    return;
end

if map(int32(q_goal(2)),int32(q_goal(1))) == 0
    disp('Start Point in obstacle region.\n failed.');
    return;
end

tic;
for i = 1:k % iteration limit is k
    % generate random point in map
    % probability p, using q_goal as q_rand
    if QGoalSelectionProbability < p
        q_rand = q_goal;
    else 
        q_rand = QRandGeneration(mapHeight,mapWidth);
    end
    
    % select nearest point in SET vertices
    q_near = QNearSelection(vertices,q_rand);
    
    % generate new point in map
    q_new = QNewGeneration(q_near, q_rand, delta_q);
    
    check_q_new = int32(floor(q_new));
    
    if all(isnan(check_q_new))
        continue;
    end
    
    % check q_new out of boundary
    if check_q_new(1) < 1 || check_q_new(1) > mapWidth || check_q_new(2) < 1 || check_q_new(2) > mapHeight
        continue;
    end
    
    % new point is in free space
    if map(check_q_new(2), check_q_new(1)) == 1
        % edge {q_new,q_near} is in free space
        if QNewQNearEdgeInFreeSpace(map, q_near, q_new)
            % add vertices and edge
            vertices = [vertices; q_new];
            edge = [edge; q_near; q_new];    
            % q_goal is reachable, return
            if QGoalTouched(map,q_new,q_near,q_goal)
                [~,touchpoint] = QGoalTouched(map,q_new,q_near,q_goal);
                % q_near touched
                if touchpoint == 1
                    vertices = [vertices; q_goal];
                    edge = [edge; q_near; q_goal];
                % q_new touched
                else
                    vertices = [vertices; q_goal];
                    edge = [edge; q_new; q_goal];
                end
                time = toc;
                result = 1;
                return;
            end
        end
    end
end
result = 0;
end
