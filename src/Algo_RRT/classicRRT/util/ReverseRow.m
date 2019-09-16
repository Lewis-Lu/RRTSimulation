function map = ReverseRow(rawMap)
    [mapHeight,~] = size(rawMap);
    for i = 1 : floor(mapHeight/2)
        rear = mapHeight-i+1;
        tmp = rawMap(i,:);
        rawMap(i,:) = rawMap(rear,:);
        rawMap(rear,:) = tmp;
    end
    map = rawMap;
end