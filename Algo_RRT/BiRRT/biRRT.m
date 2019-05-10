% function [result, time] = biRRT(map, q_start, q_goal, p, delta_q)
function [result, time] = biRRT(map, q_start, q_goal, delta_q)

addpath(genpath('utilFunc'));
addpath(genpath('utilMap'));

k = 10000;

verticesSrc = double.empty(0,2);
verticesDst = double.empty(0,2);
edgesSrc = double.empty(0,2);
edgesDst = double.empty(0,2);

% initilize data arrays
verticesSrc = [verticesSrc; q_start];
verticesDst = [verticesDst, q_goal];

[mapHeight, mapWidth] = size(map);

% initialize tree
v1 = verticesSrc;
e1 = edgesSrc;
v2 = verticesDst;
e2 = edgesDst;

tic;
for i = 1:k
    q_rand = QRandGeneration(mapHeight, mapWidth);
    q_near1 = QnearstFind(v1, q_rand);
    q_new1 = QnewGeneration(q_near1, q_rand, delta_q);
    
    if QnewQnearInFreeSpace(map, q_near1, q_new1)
        % T1 extend successfully
        v1 = [v1; q_new1];
        e1 = [e1; q_near1; q_new1];
        q_near2 = QnearstFind(v2, q_new1);
        q_new2 = QnewGeneration(q_new1, q_near2, delta_q);
        if QnewQnearInFreeSpace(map, q_near2, q_new1)
            % T2 extend succesfully
            v2 = [v2; q_new2];
            e2 = [e2; q_near2; q_new2];
            if FinalEdgeInFreeSpace(map, q_new1, q_new2)
                time = toc;
                if v1(1,:) == q_start
                    verticesSrc = v1;
                    edgesSrc = e1;
                    verticesDst = v2;
                    edgesDst = e2;
                else
                    verticesSrc = v2;
                    edgesSrc = e2;
                    verticesDst = v1;
                    edgesDst = e1;
                end
                result = 1;
                return;
            end
        end
    end
    % swap
    v_temp = v1;
    e_temp = e1;
    v1 = v2;
    e1 = e2;
    v2 = v_temp;
    e2 = e_temp;
end
time = toc;
result = 0;
end
