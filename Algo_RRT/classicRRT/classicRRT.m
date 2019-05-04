%% classic RRT implementation
clc; 
clear;

global a;
global time;

addpath(genpath('util'));
addpath(genpath('utilEnv'));

%% Set Parameters and Assistant Vectors

% all environments are set to be 500*500
q_start = [50, 60];
q_goal =  [450, 450];

delta_q = 20;
k = 10000;
p = 0.7;

edge = double.empty(0,2);
vertices = double.empty(0,2);
vertices = q_start;

trick = 0;
map = im2bw(imread('utilMap\clusterMap.bmp'));
[mapHeight, mapWidth] = size(map);

originMap = map;
map = PreprocessMap(map);

if map(int32(q_start(2)),int32(q_start(1))) == 0
    disp('Start Point in obstacle region.\n failed.');
    return;
end

if map(int32(q_goal(2)),int32(q_goal(1))) == 0
    disp('Start Point in obstacle region.\n failed.');
    return;
end

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
                toc;
                disp('succeed.');
                a = [a;1];
                time = [time; toc];
                % it returns!!!!!!!!!!!!!!!!!!!!!!!!!
                return;
            end
        end
    end
end
time = [time; toc];
disp('failed.');
a = [a; 0];
