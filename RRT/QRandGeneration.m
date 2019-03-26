% Generate a random point in dimension of the map
function [QRand] = QRandGeneration(mapHeight, mapWidth)
    QRand = [randi(mapHeight), randi(mapWidth)];
end