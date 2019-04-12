% plot potential function
fig = figure;
imshow(map);
hold on;

plot(q_start(1),q_start(2),'ro', 'MarkerSize', 10);
plot(q_goal(1),q_goal(2),'ro', 'MarkerSize', 10);
