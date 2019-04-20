% plotting
addpath(genpath('utilEnv'));
addpath(genpath('utilFunc'));

fig = figure;
imshow(originMap);
hold on;

plot(q_start(1),q_start(2),'r*', 'MarkerSize', 10);
plot(q_goal(1),q_goal(2),'b*', 'MarkerSize', 10);

for i = 1:length(verticesSrc)
    plot(verticesSrc(i,1), verticesSrc(i,2), 'r*');
end

for i = 1:2:length(edgesSrc)
    plot([edgesSrc(i,1), edgesSrc(i+1,1)],[edgesSrc(i,2), edgesSrc(i+1,2)],'r--');
end

for i = 1:length(verticesDst)
    plot(verticesDst(i,1), verticesDst(i,2), 'b*');
end

for i = 1:2:length(edgesDst)
    plot([edgesDst(i,1), edgesDst(i+1,1)],[edgesDst(i,2), edgesDst(i+1,2)],'b--');
end

figure;
imshow(map);
hold on;

OpverticesSrc = verticesSrc;
OpverticesDst = verticesDst;
OpedgesSrc = edgesSrc;
OpedgesDst = edgesDst;

[OpverticesSrc, OpedgesSrc] = Skeleton(OpverticesSrc, OpedgesSrc, OpverticesSrc(end,:));
[OpverticesDst, OpedgesDst] = Skeleton(OpverticesDst, OpedgesDst, OpverticesDst(end,:));

skeletonVertices = OpverticesSrc;
skeletonVertices(end,:) = [];
OpverticesDst = flipud(OpverticesDst);
skeletonVertices = cat(1,skeletonVertices,OpverticesDst);
% skeletonVertices = unique(skeletonVertices,'rows');

skeletonEdges = OpedgesSrc;
OpedgesDst = flipud(OpedgesDst);
skeletonEdges = cat(1, skeletonEdges, OpedgesDst);

for i = 1:length(skeletonVertices)
    plot(skeletonVertices(i,1), skeletonVertices(i,2), 'g*');
end

for i = 1:2:length(skeletonEdges)
    plot([skeletonEdges(i,1), skeletonEdges(i+1,1)],[skeletonEdges(i,2), skeletonEdges(i+1,2)],'g-');
end

smooth_vertices = Smooth(map, skeletonVertices);

smoothEdges = double.empty(0,2);
for i = 1:length(smooth_vertices)-1
    smoothEdges = [smoothEdges; smooth_vertices(i,:); smooth_vertices(i+1,:)];
    plot([smooth_vertices(i,1),smooth_vertices(i+1,1)],[smooth_vertices(i,2),smooth_vertices(i+1,2)],'k-o');
end

figure;
imshow(originMap);
hold on

for i = 1:length(smooth_vertices)-1
    smoothEdges = [smoothEdges; smooth_vertices(i,:); smooth_vertices(i+1,:)];
    plot([smooth_vertices(i,1),smooth_vertices(i+1,1)],[smooth_vertices(i,2),smooth_vertices(i+1,2)],'g-o');
end

ControlPoints = double.empty(0,2);
smooth_curvation = double.empty(0,2);

ControlCvxHullPoints = double.empty(0,2);

TrajLinePart = double.empty(0,2);
TrajLinePart = [TrajLinePart; q_start];

for i = 2 : length(smooth_vertices)-1
    [ctrl_first, ctrl_second] = Curvation(map, smooth_vertices, i);
    
    ControlPoints = [ctrl_first; smooth_vertices(i,:); ctrl_second];
    
    smooth_curvation = QuadraticBezierSpline(ControlPoints);
    
    ControlCvxHullPoints = [ControlCvxHullPoints; ControlPoints];
    
    TrajLinePart = [TrajLinePart; ctrl_first; ctrl_second];
    
    plot(ctrl_first(1), ctrl_first(2),'bo', 'MarkerSize', 8);
    plot(ctrl_second(1), ctrl_second(2),'bo', 'MarkerSize', 8);
    
    for k = 1:length(ControlPoints)
        vertice_one = k;
        vertice_two = k+1;
        if k+1 == 4
            vertice_two = 1;
        end
        plot([ControlPoints(vertice_one,1),ControlPoints(vertice_two,1)],[ControlPoints(vertice_one,2),ControlPoints(vertice_two,2)],'--k')
    end
    
    for j = 1:length(smooth_curvation)-1
        plot([smooth_curvation(j,1),smooth_curvation(j+1,1)], [smooth_curvation(j,2),smooth_curvation(j+1,2)],'r-');
    end
end

TrajLinePart = [TrajLinePart; q_goal];

for i = 1 : 2 : length(TrajLinePart)
    plot([TrajLinePart(i,1), TrajLinePart(i+1,1)], [TrajLinePart(i,2), TrajLinePart(i+1,2)],'r-');
end
