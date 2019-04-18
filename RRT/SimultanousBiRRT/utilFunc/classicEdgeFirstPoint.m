function [first] = classicEdgeFirstPoint(edges)
    first = double.empty(0,2);
    for i = 1:2:length(edges)
        first = [first; edges(i,:)];
    end
    first = unique(first, 'rows');
end