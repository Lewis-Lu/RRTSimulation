function [vertices, edges, path] = ClassicRRT(map, q_start, q_goal, k, delta_q, p) 
    % set default values
    k_iter = 10000;
    delta = 50;
    prob = 0.8;
    [mapHeight, mapWidth] = size(map);
    
    % set default argument values
    if nargin < 2 % no start/goal point
        error ('Lacking argument of start & goal points.');
    elseif nargin < 3 % no goal coordinate
        error ('Lacking argument of start point.');
    elseif nargin < 4 
        delta_q = delta;
        k = k_iter;
        p = prob;
    elseif nargin < 5
        k = k_iter;
        p = prob;
    elseif nargin < 6
        p = prob;
    elseif nargin > 6
        error('Arguments exceed.');
    end
    
    q_start = int32(q_start);
    q_goal = int32(q_goal);
    
    % check argument value boundaries
    checkParameters(map, q_start, q_goal, k, delta_q, p);
    
    % initialization
    vertices = q_start;
    edges  = int32.empty(0, 2);
    q_rand = int32.empty(0, 2);
    q_near = int32.empty(0, 2);
    q_new  = int32.empty(0, 2);
    path   = int32.empty(0, 2);
    
    % iteration begins
    for i = 0:k
        % generate q_rand
        % for probability of p, q_rand <- q_goal
        if QGoalSelectionProbability < p
            % using q_goal as q_rand
            q_rand = q_goal;
        else
            q_rand = QRandGeneration(mapHeight, mapWidth);
        end
        
        % select nearest vertice to q_rand in vertices
        q_near = SelectQNear(vertices, q_rand);
        
        % generate q_new
        q_new  = GenerateQNew(q_near, q_rand, delta_q);
    
        % q_new out of boundary, continue, to outer loop
        if q_new(1) < 1 || q_new(2) < 1 || q_new(1) > mapHeight || q_new(2) > mapWidth
            continue;
        end
        
        if map(q_new(1), q_new(2)) == 1 % q_new in free space
           if QNewQnearEdgeInFreeSpace(map, q_near, q_new) % edge in free space
               % add to vertices
               % add to edges
               vertices = [vertices; q_new];
               edges = [edges; [q_near,q_new]];
               if QGoalTouched(map, q_new, q_goal)
                   % add to path, return
                   disp('Touchdown!!');
                   return;
               end
           end
        end
    end
    % not found a path
    error('Not found a path');
end
