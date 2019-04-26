% Potential = RepFunction(mapWidth, mapHeight, map, DQ, ita)
function Potential = RepFunction(mapWidth, mapHeight, map, DQ, ita)
    for x = 1:mapWidth
        for y = 1:mapHeight
            if x < DQ
                left_limit = 1;
                right_limit = x + DQ;
            end

            if mapWidth - x < DQ
                left_limit = x - DQ;
                right_limit = mapWidth;
            end

            if y < DQ
                up_limit = 1;
                bottom_limit = y + DQ;
            end

            if mapHeight - y < DQ
                up_limit = y - DQ;
                bottom_limit = mapHeight;
            end

            for i = left_limit: right_limit
                for j = up_limit: bottom_limit
                    Distance = Dist([i,j],[x,y]);
                    RepVal = 0.5 * ita * (1/DQ - 1/Distance)^2;
                    map(int32(j),int32(i)) = map(int32(j),int32(i)) + RepVal;
                end
            end
        end
    end
    Potential = map;
end