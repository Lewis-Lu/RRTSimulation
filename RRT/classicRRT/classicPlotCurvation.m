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
    plot([op_edge(i,1),op_edge(i+1,1)],[op_edge(i,2),op_edge(i+1,2)],'r-*');
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
   plot([smooth_edges(i,1),smooth_edges(i+1,1)],[smooth_edges(i,2),smooth_edges(i+1,2)],'g-o');
end

% add control point for curvation
for i = 2 : length(smooth_vertices)-1
    [ctrl_first, ctrl_second] = classicRRTcurvation(smooth_vertices, i);
    plot(ctrl_first(1), ctrl_first(2),'b*', 'MarkerSize', 8);
    plot(ctrl_second(1), ctrl_second(2),'b*', 'MarkerSize', 8);
end
