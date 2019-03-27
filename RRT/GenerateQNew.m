function [q_new] = GenerateQNew(q_near, q_rand, delta_q)
    % generate q_new in the direction from q_near to q_rand
    v = double(int32(q_rand) - int32(q_near));
    u = v / norm(v);
    q_new = int32(int32(q_near) + int32(u*delta_q));
end