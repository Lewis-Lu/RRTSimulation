function [second] = classicEdgeSecondPoint(edges)
    second = double.empty(0,2);
    for i = 1:2:length(edges)
        second = [second; edges(i+1,:)];
    end
    second = unique(second, 'rows');
end