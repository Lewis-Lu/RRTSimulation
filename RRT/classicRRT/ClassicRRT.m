%% classic RRT implementation
clc;
% clear;
global a;
global time;

addpath(genpath('classicRRTfunc'));
addpath(genpath('utilEnv'));

%% Set Parameters and Assistant Vectors

% maze.mat
q_start = [100, 100];
q_goal = [700, 600];

% custom.mat --> narrow_passage
% q_start = [50, 50];
% q_goal = [500, 50];

% % blank.mat --> blank environment
% q_start = [225,225];
% q_goal = [400,400];

delta_q = 50;
k = 10000;
p = 0.7;
% p = 1;
edge = double.empty(0,2);
vertices = double.empty(0,2);
vertices = q_start;

% load map default
trick = 0;
map = load('maze.mat');
map = 1 - ReverseRow(map.map);

originMap = map;

map = PreprocessMap(map);
[mapHeight, mapWidth] = size(map);

% load map custom
% trick = 1;
% map = load('custom.mat');
% % map = ReverseRow(map);
% map = map.custom;
% [mapHeight, mapWidth] = size(map);

% % load map blank
% trick = 2;
% map = load('blank.mat');
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
    
    check_q_new = floor(q_new);
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
%                 disp('succeed.');
                a = [a;1];
                time = [time; toc];
                % it returns!!!!!!!!!!!!!!!!!!!!!!!!!
                % f****k
                return;
            end
        end
    end
end
time = [time; toc];
% disp('failed.');
a = [a; 0];
