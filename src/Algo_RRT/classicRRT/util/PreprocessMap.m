% pre_map = PreprocessMap(map)
function pre_map = PreprocessMap(map)
    obs = 0;
    free = 1;
    
    pre_map = map;
    
    [mapHeight, mapWidth] = size(pre_map);
    
    i = 1;
    while i < mapHeight
        for j = 1:mapWidth
            if pre_map(i,j) == obs && pre_map(i+1,j) == free
                pre_map(i+1,j) = obs;
                pre_map(i+2,j) = obs;
                pre_map(i+3,j) = obs;
                pre_map(i+4,j) = obs;
                pre_map(i+5,j) = obs;
                pre_map(i+6,j) = obs;
            end
        end
        i = i+7;
    end
end
