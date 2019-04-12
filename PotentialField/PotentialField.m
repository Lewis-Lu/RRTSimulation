%% Potential Field Function
clc; clear;

%% Load maze.mat and parameters
q_start = [50,50];
q_goal = [500, 50];

map = load('maze.mat');
map = 1 - ReverseRow(map.map);
[mapHeight, mapWidth] = size(map);

%% potential field function modeling

