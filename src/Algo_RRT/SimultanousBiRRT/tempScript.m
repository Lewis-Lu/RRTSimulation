
addpath(genpath('utilEnv'));
addpath(genpath('utilFunc')); 

fig = figure;
imshow(originMap);
hold on;

[f,s] = FindTwoClosestPoint(verticesSrc, verticesDst);

plot(f(1),f(2),'bd', 'MarkerSize', 10);
plot(s(1),s(2),'bd', 'MarkerSize', 10);


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
