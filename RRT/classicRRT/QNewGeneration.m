% QNewGeneration(q_near, q_rand, delta_q)
function [q_new] = QNewGeneration(q_near, q_rand, delta_q)
    v = q_rand - q_near; % vector
    u = v / norm(v);
    q_new = floor(q_near + u*delta_q);
end