% Data Process
clear;
load('Data\Data1.mat');
% 
Success_Index = find(a == 1)';
Time_Success = time(Success_Index)';

aver = mean(Time_Success);
[max_value,max_index] = max(Time_Success);
[min_value,min_index] = min(Time_Success);

Num_aver_below = length(find(Time_Success < aver));
Rate = Num_aver_below / success;

global biRRTAver;
global biRRTBelowAverRate;

biRRTAver = aver;
biRRTBelowAverRate = Rate;
% 
% figure;
% b = bar(Time_Success);
% 
% grid on
% hold on
% 
% plot([0,length(Time_Success)], [aver, aver], 'r--');
% plot([0,length(Time_Success)], [max_value, max_value], 'b--');
% plot([0,length(Time_Success)], [min_value, min_value], 'g--');
% 
% xlim([0, length((Time_Success))]);
% 
% figure;
% 
% hold on;
% grid on;
% 
% plot(Success_Index, Time_Success, 'r-');
% plot([0,length(Time_Success)], [aver, aver], 'b--');
% 
% xlim([0, length((Time_Success))]);

figure;
c = categorical({'Success', 'Failure'});
b = bar(c, [success iter-success],0.5, 'b');
