q_start = [206, 198];
q_goal = [416, 612];

% choose map
prompt = 'Using default map? [y/n]: ';
default = input(prompt,'s');
if default == 'y'
    map = load('maze.mat');
    map = map.map;
    map = 1-map;
else
    % Usage: input JPG name, convert it to test.mat in workspace
    map = Convertjpg2mat;
    map = map.mat;
end

% [vertices, edges, path] = ClassicRRT(map, q_start, q_goal);

[mH,mW] = size(map);
q_rand = QRandGeneration(mH, mW);

figure;
imshow(map);
hold on;
plot(q_start(1), q_start(2), 'r*');
plot(q_goal(1), q_goal(2), 'r*');
plot(q_rand(1), q_rand(2), 'b*','MarkerSize',20);