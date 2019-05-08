%% simultanous bi-RRT implementation
clc; 
clear;

addpath(genpath('utilEnv'));
addpath(genpath('utilFunc'));
addpath(genpath('utilMap'));

global a;
global time;

q_start = [50, 60];
q_goal = [450, 450];

delta_q = 20;
k = 10000;
p = 0.7;

verticesSrc = double.empty(0,2);
verticesDst = double.empty(0,2);
edgesSrc = double.empty(0,2);
edgesDst = double.empty(0,2);

verticesSrc = [verticesSrc; q_start];
verticesDst = [verticesDst, q_goal];

% trick = 0;
map = im2bw(imread('utilMap\circlesMap.bmp'));
originMap = map;
% map to be bolder
map = PreprocessMap(map);
[mapHeight, mapWidth] = size(map);

%% loop begins

local_minima = 0;

tic;
for i = 1:k
    
    if local_minima
        % use randomized point to draw out of local minima
        q_rand = QRandGeneration(mapHeight, mapWidth);
        RandSrc = q_rand;
        RandDst = q_rand;
        
        NearSrc = QnearstFind(verticesSrc, q_rand);
        NearDst = QnearstFind(verticesDst, q_rand);
    else
        [SrcIdx, DstIdx] = FindTwoClosestPointIndex(verticesSrc, verticesDst);
        RandSrc = verticesDst(DstIdx,:);
        RandDst = verticesSrc(SrcIdx,:);
        
        NearSrc = verticesSrc(SrcIdx,:);
        NearDst = verticesDst(DstIdx,:);
    end
 
    NewSrc = QnewGeneration(NearSrc, RandSrc, delta_q);
    NewDst = QnewGeneration(NearDst, RandDst, delta_q);
    
    CheckSrc = int32(NewSrc);
    CheckDst = int32(NewDst);
    
    if CheckSrc(1) < 1 || CheckSrc(1) > mapWidth || CheckSrc(2) < 1 || CheckSrc(2) > mapHeight ...
            ||CheckDst(1) < 1 || CheckDst(1) > mapWidth || CheckDst(2) < 1 || CheckDst(2) > mapHeight
        continue;
    end
    
    if map(CheckSrc(2), CheckSrc(1)) && map(CheckDst(2), CheckDst(1))
        % new points both in free space
        if  ~QnewQnearInFreeSpace(map, NearSrc, NewSrc) || ...
                ~QnewQnearInFreeSpace(map, NearDst, NewDst)
            % extend one of them or neither
            local_minima = 1;
            if QnewQnearInFreeSpace(map, NearSrc, NewSrc)
                verticesSrc = [verticesSrc; NewSrc];
                edgesSrc = [edgesSrc; NearSrc; NewSrc];
            elseif QnewQnearInFreeSpace(map, NearDst, NewDst)
                verticesDst = [verticesDst; NewDst];
                edgesDst = [edgesDst; NearDst; NewDst];
            end
        else QnewQnearInFreeSpace(map, NearSrc, NewSrc) && ...
                QnewQnearInFreeSpace(map, NearDst, NewDst)
            % both extend
            verticesSrc = [verticesSrc; NewSrc];
            edgesSrc = [edgesSrc; NearSrc; NewSrc];
            verticesDst = [verticesDst; NewDst];
            edgesDst = [edgesDst; NearDst; NewDst];
            
            if  FinalEdgeInFreeSpace(map, NewSrc, NewDst)
                verticesSrc = [verticesSrc; NewDst];
                edgesSrc = [edgesSrc; NewSrc; NewDst];
                disp('success')
                toc;
                return;
            end
        end
    end
end
disp('failure');
a = [a;0];
time = [time; toc];
