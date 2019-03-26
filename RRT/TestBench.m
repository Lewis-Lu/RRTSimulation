clc;

k = 10000;

% q_start = [80, 70]; 
%% Convert .jpg file to .mat file
% Usage: input JPG name, convert it to test.mat in workspace
% Convertjpg2mat
%

%% Using converted mat
map = load('maze.mat');
map = map.map;
q_start = [80, 70]; 
q_goal = [707, 615];

%% Set Parameters
p = 0.8;
[mapHeight, mapWidth] = size(map);

for iter= 1:1:k
    
    if(QGoalSelectionProbability > p)
        % generate q_rand
        q_rand = QRandGeneration(mapHeight, mapWidth);
        
    else
        % q_goal as q_rand
        q_rand = q_goal;
        
    end
end