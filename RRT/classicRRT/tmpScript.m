% classicRRT;
% % classicPlot;
% classicPlotCurvation;

a = [];
time = [];
clear;

iteration_time = 500;

for i = 1 : iteration_time
    classicRRT;
%     classicPlotCurvation;
end

success = length(find(a == 1));
success_rate = success / iteration_time;
