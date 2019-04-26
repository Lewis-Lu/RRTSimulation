%% Potential Field Function
clc; clear;

%% Load maze.mat and parameters
q_start = [50,50];
q_goal =  [500,50];

map = load('maze.mat');
map = 1 - ReverseRow(map.map);
[mapHeight, mapWidth] = size(map);

zeta = 1;
DQ = 10;
ita = 100;
zta = 10;

PF = zeros(mapHeight, mapWidth);

%% potential field function modeling
tic;
% RepMatric = RepFunction(mapWidth, mapHeight, PF, DQ, ita);

for i = 1:mapWidth
   for j = 1:mapHeight
       q_cur = [i,j];
       PF(j,i) = 1/2 * zeta * Dist(q_cur, q_goal);
   end
end
% 
% figure;
% [X,Y] = meshgrid(1:mapWidth, 1:mapHeight);
% meshz(Y,X,PF);

toc;

figure;
[X,Y] = meshgrid(1:mapWidth, 1:mapHeight);
meshz(Y,X,PF);

% figure;
% imshow(map);
% hold on
% plot(q_goal(1), q_goal(2), 'r*');
% plot(q_goal(1)+10, q_goal(2), 'b*');