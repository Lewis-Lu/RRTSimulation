% q_nearst = QnearstFind(vertices, q_rand)
function q_nearst = QnearstFind(vertices, q_rand)
    [v_num, ~] = size(vertices);
    dis = double.empty(0,2);
    for i = 1:v_num
        res = vertices(i,:) - q_rand;
        dis(i) = res(1)^2 + res(2)^2;
    end

    [~,index] = min(dis);

    q_nearst = vertices(index(1),:);
end