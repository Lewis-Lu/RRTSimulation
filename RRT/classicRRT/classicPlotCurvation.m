addpath(genpath('classicRRTfunc'));

% plot trajectory with curve
figure;
imshow(map);
hold on;

% do cut leaf operation
% do path planning
op_edge = edge;
op_vertices = vertices;

[leaf, op_vertices, op_edge]= CutLeaf(op_vertices,op_edge,q_goal);
while ~isempty(leaf)
    [leaf, op_vertices, op_edge] = CutLeaf(op_vertices, op_edge, q_goal);
end

for i = 1: 2 :length(op_edge)
    plot([op_edge(i,1),op_edge(i+1,1)],[op_edge(i,2),op_edge(i+1,2)],'g-*');
end

% smooth the path
smooth_vertices = classicRRTsmooth(map,op_vertices);
smooth_vertices = [smooth_vertices; q_goal];
smooth_edges = double.empty(0,2);

for i = 1 : length(smooth_vertices)-1
    smooth_edges = [smooth_edges; smooth_vertices(i,:)];
    smooth_edges = [smooth_edges; smooth_vertices(i+1,:)];
end

for i = 1:2:size(smooth_edges)
   plot([smooth_edges(i,1),smooth_edges(i+1,1)],[smooth_edges(i,2),smooth_edges(i+1,2)],'r-o');
end

figure;
imshow(map);
hold on;

for i = 1:2:size(smooth_edges)
   plot([smooth_edges(i,1),smooth_edges(i+1,1)],[smooth_edges(i,2),smooth_edges(i+1,2)],'g-o');
end

% add control point for curvation
ControlPoints = double.empty(0,2);
smooth_curvation = double.empty(0,2);

ControlCvxHullPoints = double.empty(0,2);

TrajLinePart = double.empty(0,2);
TrajLinePart = [TrajLinePart; q_start];

for i = 2 : length(smooth_vertices)-1
    [ctrl_first, ctrl_second] = classicRRTcurvation(smooth_vertices, i);
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
    plot([TrajLinePart(i,1),TrajLinePart(i+1,1)],[TrajLinePart(i,2),TrajLinePart(i+1,2)],'r-');
end
