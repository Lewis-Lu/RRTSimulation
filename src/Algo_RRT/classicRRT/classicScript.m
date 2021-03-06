addpath(genpath('utilEnv'));
addpath(genpath('util'));
addpath(genpath('utilMap'));

clear;clc;

% configuration
q_start = [50, 60];
q_goal = [450, 450];
p = 0.6;
delta_q = 30;

% map information
map = im2bw(imread('utilMap\clusterMap.bmp'));
originMap = map;
% map to be bolder
map = PreprocessMap(map);

sim_total = 1;
sim_success = 0;
sim_failure = 0;

time = double.empty(0, 1);

for i = 1:sim_total
    [result, t, vertices, edge] = classicRRT(map, q_start, q_goal, p, delta_q);
    if result
        sim_success = sim_success + 1;
        time = [time;t];
    else
        sim_failure = sim_failure + 1;
    end
end

% classicPlotCurvation;

disp(sim_success);

% figure;
% hold on
% b1 = bar(time',0.4,'b');
% plot([0, sim_total],[mean(time),mean(time)], 'r-');
% xlim([0,100]);
% 
% ylabel('Planning Time (s)');
