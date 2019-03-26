%% Plot parameters
% map
% q_start, q_goal
% vertices
% edges

%% Plotting
figure;
imshow(int32(1-map),[]);
hold on
plot(q_start(1),q_start(2),'r*');
plot(q_goal(1),q_goal(2),'r*');