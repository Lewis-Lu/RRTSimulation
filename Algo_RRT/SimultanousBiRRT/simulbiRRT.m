% function result = simulbiRRT(map, q_start, q_goal, p, delta_q)
function [result, time] = simulbiRRT(map, q_start, q_goal, p, delta_q)
addpath(genpath('utilEnv'));
addpath(genpath('utilFunc'));
addpath(genpath('utilMap'));

k = 10000;

verticesSrc = double.empty(0,2);
verticesDst = double.empty(0,2);
edgesSrc = double.empty(0,2);
edgesDst = double.empty(0,2);

verticesSrc = [verticesSrc; q_start];
verticesDst = [verticesDst, q_goal];

[mapHeight, mapWidth] = size(map);

rand_flag = 0;

tic;
for i = 1:k
    if p > QGoalSelectionProbability
        rand_flag = 1;
    end
    
    % use flag to judge whether connect or randomize
    
    if rand_flag
        % use randomized point to draw out of local minima
        RandSrc = QRandGeneration(mapHeight, mapWidth);
        %         RandDst = QRandGeneration(mapHeight, mapWidth);
        RandDst = RandSrc;
        
        NearSrc = QnearstFind(verticesSrc, RandSrc);
        NearDst = QnearstFind(verticesDst, RandDst);
    end
    
    if rand_flag == 0
        [CloseInSrc, CloseInDst] = FindTwoClosestPoint(verticesSrc, verticesDst);
        
        if Dist(CloseInSrc, CloseInDst) < delta_q
            if FinalEdgeInFreeSpace(map, CloseInSrc, CloseInDst)
                verticesSrc = [verticesSrc; CloseInDst];
                edgesSrc = [edgesSrc; CloseInSrc; CloseInDst];
                result = 1;
                time = toc;
                return;
            end
        end
        
        RandSrc = CloseInDst;
        RandDst = CloseInSrc;
        
        NearSrc = CloseInSrc;
        NearDst = CloseInDst;
    end
    
    NewSrc = QnewGeneration(NearSrc, RandSrc, delta_q);
    NewDst = QnewGeneration(NearDst, RandDst, delta_q);
    
    CheckSrc = int32(NewSrc);
    CheckDst = int32(NewDst);
    
    % out of map, continue.
    if CheckSrc(1) < 1 || CheckSrc(1) > mapWidth || CheckSrc(2) < 1 || CheckSrc(2) > mapHeight ...
            ||CheckDst(1) < 1 || CheckDst(1) > mapWidth || CheckDst(2) < 1 || CheckDst(2) > mapHeight
        continue;
    end
    
    if map(CheckSrc(2), CheckSrc(1)) && ...
            map(CheckDst(2), CheckDst(1))
        
        
        if  ~QnewQnearInFreeSpace(map, NearSrc, NewSrc)
            if QnewQnearInFreeSpace(map, NearDst, NewDst)
                verticesDst = [verticesDst; NewDst];
                edgesDst = [edgesDst; NearDst; NewDst];
            end
        end
        
        if ~QnewQnearInFreeSpace(map, NearDst, NewDst)
            if QnewQnearInFreeSpace(map, NearSrc, NewSrc)
                verticesSrc = [verticesSrc; NewSrc];
                edgesSrc = [edgesSrc; NearSrc; NewSrc];
            end
        end
        
        if QnewQnearInFreeSpace(map, NearSrc, NewSrc)
            if QnewQnearInFreeSpace(map, NearDst, NewDst)
                % both extend
                
                verticesSrc = [verticesSrc; NewSrc];
                edgesSrc = [edgesSrc; NearSrc; NewSrc];
                verticesDst = [verticesDst; NewDst];
                edgesDst = [edgesDst; NearDst; NewDst];
                
                if Dist(NewSrc, NewDst) < 50
                    if  FinalEdgeInFreeSpace(map, NewSrc, NewDst)
                        verticesSrc = [verticesSrc; NewDst];
                        edgesSrc = [edgesSrc; NewSrc; NewDst];
                        result = 1;
                        time = toc;
                        return;
                    end
                end
            end
        end
    end
end
result = 0;
toc;
end
function d = Dist(NewSrc, NewDst)
d = sum((NewSrc - NewDst).^2);
end
