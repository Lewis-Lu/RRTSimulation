%% classic RRT implementation
clc; clear;
% addpath(genpath(''));
addpath(genpath('utilEnv'));

%% Set Parameters and Assistant Vectors

% maze.mat
q_start = [100, 100];
q_goal = [700, 600];

delta_q = 50;
k = 100;
p = 0.7;

verticesA = double.empty(0,2);
edgesA = double.empty(0,2);
verticesB = double.empty(0,2);
edgesB = double.empty(0,2);

verticesA = [verticesA; q_start];
verticesB = [verticesB; q_goal];

% load map default
map = load('maze.mat');
map = 1 - ReverseRow(map.map);
[mapHeight, mapWidth] = size(map);


%%
tic;
% iteration begins
for i = 1:k
    % copy information to manipulate
    if mod(i,2) == 1 % q_start tree expand
        VerticeSrc = verticesA;
        EdgeSrc = edgesA;
        VerticeDst = verticesB;
        EdgeDst = edgesB;
        
    else  % q_goal tree expand
        VerticeSrc = verticesB;
        EdgeSrc = edgesB;
        VerticeDst = verticesA;
        EdgeDst = edgesA;
        
    end
    
    % VerticeSrc, VerticeDst
    % EdgeSrc, EdgeDst
    
    q_rand = QRandGeneration(mapHeight, mapWidth);
    
    q_nearst1 = QnearstFind(VerticeSrc, q_rand);
    
    q_new1 = QNewGeneration(q_nearst1, q_rand, delta_q);
    
    check_q_new = floor(q_new1);
    % check q_new out of boundary
    if check_q_new(1) < 1 || check_q_new(1) > mapWidth || check_q_new(2) < 1 || check_q_new(2) > mapHeight
        continue;
    end
    
    if CheckEdgeInFreeSpace(map, q_new1, q_nearst1)
        % update SrcTree
        VerticeSrc = [VerticeSrc; q_new1];
        EdgeSrc = [EdgeSrc; q_nearst1 ; q_new1];
        
%         % generate DstTree new node
%         q_nearst2 = QnearstFind(VerticeDst, q_new1);
%         
%         q_new2 = QNewGeneration(q_nearst2, q_new1, delta_q);
%         
%         check_q_new = floor(q_new2);
%         % check q_new out of boundary
%         if check_q_new(1) < 1 || check_q_new(1) > mapWidth || check_q_new(2) < 1 || check_q_new(2) > mapHeight
%             continue;
%         end
%         
%         if CheckEdgeInFreeSpace(map, q_new2, q_nearst2)
%             % update DstTree
%             VerticeDst = [VerticeDst; q_new2];
%             EdgeDst = [EdgeDst; q_nearst2; q_new2];
%         end
    end
    
    % update tree infomations
    if mod(i,2) == 1 % q_start tree expand
        verticesA = VerticeSrc;
        edgesA = EdgeSrc;
        verticesB = VerticeDst;
        edgesB = EdgeDst;
        
    else  % q_goal tree expand
        verticesB = VerticeSrc;
        edgesB = EdgeSrc;
        verticesA = VerticeDst;
        edgesA = EdgeDst;
    end
end
toc;
disp('failed.');
