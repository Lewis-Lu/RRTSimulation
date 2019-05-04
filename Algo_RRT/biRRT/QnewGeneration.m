% q_new = QnewGeneration(q_nearst, q_rand, delta)
function q_new = QnewGeneration(q_nearst, q_rand, delta)
    v = q_rand - q_nearst;
    
    u = v / norm(v);
    
    q_new = q_nearst + u*delta;
    
end