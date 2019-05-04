% Artificial Potential Function
function h=distanceCost(a,b)
h = sqrt(sum(a-b).^2);