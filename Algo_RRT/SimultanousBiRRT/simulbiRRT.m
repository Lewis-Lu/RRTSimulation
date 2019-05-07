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
map = im2bw(imread('utilMap\clusterMap.bmp'));
originMap = map;
% map to be bolder
map = PreprocessMap(map);
[mapHeight, mapWidth] = size(map);

%% loop begins

tic;
for i = 1:k
   if p > QGoalSelectionProbability
       randSrc = q_goal;
       randDst = q_start;
   else
       randSrc = QRandGeneration(mapHeight, mapWidth);
       randDst = randSrc;
%        randDst = QRandGeneration(mapHeight, mapWidth);
   end
   
   nearSrc = QnearstFind(verticesSrc, randSrc);
   newSrc = QnewGeneration(nearSrc, randSrc, delta_q);
   checkSrc = floor(newSrc);

%%%%%%%%%%%
   nearDst = QnearstFind(verticesDst, randDst);   
   newDst = QnewGeneration(nearDst, randDst, delta_q);
   checkDst = floor(newDst);
    
   if all(isnan(checkSrc)) || all(isnan(checkDst))
       continue;
   end
   
   if checkSrc(1) < 1 || checkSrc(1) > mapWidth || checkSrc(2) < 1 || checkSrc(2) > mapHeight 
       continue;
   end

%%%%%%%%%%%
   if checkDst(1) < 1 || checkDst(1) > mapWidth || checkDst(2) < 1 || checkDst(2) > mapHeight
       continue;
   end
   
   if map(checkSrc(2),checkSrc(1)) == 1 && map(checkDst(2), checkDst(1)) == 1
       if QnewQnearInFreeSpace(map, nearSrc, newSrc) && QnewQnearInFreeSpace(map, nearDst, newDst)
           verticesSrc = [verticesSrc; newSrc];
           edgesSrc = [edgesSrc; nearSrc; newSrc];
           verticesDst = [verticesDst; newDst];
           edgesDst = [edgesDst; nearDst; newDst];
           if FinalEdgeInFreeSpace(map, newSrc, newDst)
               verticesDst = [verticesDst; newSrc];
               edgesDst = [edgesDst; newDst; newSrc];
%                verticesSrc = [verticesSrc; newDst];
%                edgesSrc = [edgesSrc; newSrc; newDst];
               toc;
               display('success');
               a = [a;1];
               time = [time; toc];
               return;
           end
       end
   end
end
toc;
disp('failure');
a = [a;0];
time = [time; toc];
