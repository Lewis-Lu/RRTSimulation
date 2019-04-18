clear; clc;

q_start = [100, 100];
q_goal = [700, 600];

pages = double.empty(0,2,2);
a = [1,2];
b = [2,3];
ptr = 1;
nxtptr = NxtPtr(ptr);
% 
% root_vertice = pages(:,:,ptr);
% goal_vertice = pages(:,:,nxtptr);
% 
% root_vertice = [root_vertice; a];
% goal_vertice = [goal_vertice; b];

pages(end+1,:,ptr) = a; 
pages(end+1,:,nxtptr) = b;

ptr = ptr + 1;

pages(end+1,:,ptr) = a; 
pages(end+1,:,nxtptr) = b;


function nxt = NxtPtr(ptr)
    nxt = ptr + 1;
    if nxt == 3 
        nxt = 1;
    end
end
