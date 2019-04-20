addpath(genpath('classicRRTfunc'));
addpath(genpath('utilEnv'));
% classicRRT;
% % classicPlot;
% classicPlotCurvation;
% 
% a = [];
% time = [];
% clear;
% 
% iteration_time = 500;
% 
% for i = 1 : iteration_time
%     classicRRT;
% %     classicPlotCurvation;
% end
% 
% success = length(find(a == 1));
% success_rate = success / iteration_time;
map = load('cluster.mat');
map = ReverseRow(map);
map = map.custom;
figure;
imshow(map);
hold on

plot(500,300,'r*');
plot(3000,1900,'r*');


