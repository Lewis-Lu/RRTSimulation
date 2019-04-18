figure;
imshow(map);
hold on

plot(q_start(1), q_start(2), 'r*', 'MarkerSize', 10);
plot(q_goal(1), q_goal(2), 'b*', 'MarkerSize', 10);

for i = 1:length(verticesA)
    plot(verticesA(i,1), verticesA(i,2), 'r*');
end

for i = 1:2:length(edgesA)
    plot([edgesA(i,1), edgesA(i+1,1)],[edgesA(i,2), edgesA(i+1,2)],'r--');
end

for i = 1:length(verticesB)
    plot(verticesB(i,1), verticesB(i,2), 'b*');
end

for i = 1:2:length(edgesB)
    plot([edgesB(i,1), edgesB(i+1,1)],[edgesB(i,2), edgesB(i+1,2)],'b--');
end
