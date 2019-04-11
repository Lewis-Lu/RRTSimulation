% traj = QuadraticBezierSpline(Points)

function traj = QuadraticBezierSpline(Points)
    upBound = 1;
    step = 0.1;
    
    traj = double.empty(0,2);
    
    for t = 0:step:upBound
        tmp = (1-t)^2 .* Points(1,:) + 2*t*(1-t).*Points(2,:) + t^2*Points(3,:);
        traj = [traj; tmp];
    end
end