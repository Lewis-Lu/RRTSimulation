% [leaf_vertices, vertice, edges] = CutLeaf(vertices, edges, q_goal)
function [leaf_vertices, vertices, edges] = CutLeaf(vertices, edges, q_goal)
    leaf_vertices = double.empty(0,2);
    edge_first_vertice = double.empty(0,2);
    edge_second_vertice = double.empty(0,2);
    path = double.empty(0,2);
    
    edge_first_vertice = classicEdgeFirstPoint(edges);
    edge_second_vertice = classicEdgeSecondPoint(edges);
    
    % find leaf vertices 
    % second is found in first --> intersection 
    % we cannot delete vertices in intersection 
    intersection_vertice = int32(ismember(edge_second_vertice, edge_first_vertice, 'rows'));
    del = (find(intersection_vertice == 1))';
        
    edge_second_vertice(del,:) = [];
    
    % q_goal cannot be leaf vertice
    goal_index = find(edge_second_vertice == q_goal);
    goal_index = goal_index(1);
    edge_second_vertice(goal_index,:) = [];
    
    % find leaf vertices
    leaf_vertices = edge_second_vertice;
    
    % update vertices and edge 
    % delete leafs from vertices and edge
    leaf_index_in_vertices = int32(ismember(vertices, leaf_vertices, 'rows'));
    index = (find(leaf_index_in_vertices == 1))';
    vertices(index,:) = [];
    
    leaf_index_in_edges = int32(ismember(edges, leaf_vertices, 'rows'));
    index = (find(leaf_index_in_edges == 1))';
    index = [index, index-1];
    edges(index,:) = [];
    
end
