% QRandGeneration(mapHeight, mapWidth)
function QRand = QRandGeneration(mapHeight, mapWidth)
    QRand = [randi(mapWidth), randi(mapHeight)];
end