function q_near= SelectQNear(vertices, q_rand)
    % using Eucleadian distance in measurement
    [v_num, ~] = size(vertices);
    dist = intmax;
    for i = 1:v_num
        res = double(int32(vertices(i,:)) - int32(q_rand));
        tmp = sqrt(res(1)^2 + res(2)^2);
        if tmp < dist
            dist = tmp;
            index = i;
        end
    end
    q_near = vertices(index,:);
end