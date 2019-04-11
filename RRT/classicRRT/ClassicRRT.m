%% classic RRT implementation
clc; clear;
addpath(genpath('classicRRTfunc'));

%% Set Parameters and Assistant Vectors
% maze.mat
% q_start = [100, 100];
% q_goal = [700, 600];

% custom.mat --> narrow_passage
q_start = [50, 50];
q_goal = [500, 50];

delta_q = 50;
k = 10000;
p = 0.7;
% p = 1;
edge = double.empty(0,2);
vertices = double.empty(0,2);
vertices = q_start;

% load map default
map = load('maze.mat');
map = 1 - ReverseRow(map.map);
[mapHeight, mapWidth] = size(map);

% % load map custom
% map = load('custom.mat');
% % map = ReverseRow(map);
% map = map.custom;
% [mapHeight, mapWidth] = size(map);

%%
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
    
    check_q_new = int32(q_new);
    % check q_new out of boundary
    if check_q_new(1) < 1 || check_q_new(1) > mapWidth || check_q_new(2) < 1 || check_q_new(2) > mapHeight
        continue;
    end
    
    % new point is in free space
    if map(check_q_new(2), check_q_new(1)) == 1
        % edge {q_new,q_near} is in free space
        if QNewQNearEdgeInFreeSpace(map,q_near, q_new)
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
                toc;
                disp('succeed.');
                % it returns!!!!!!!!!!!!!!!!!!!!!!!!!
                % f****k
                return;
            end
        end
    end
end
toc;
disp('failed.');
