classicRRT;
% classicPlot;
classicPlotCurvation;
% 
% P = [[10,10];[20,20];[30,5]];
% prior = [0,0];
% rear = [40,-10];
% 
% smooth = QuadraticBezierSpline(P);
% 
% figure;
% hold on
% plot([P(2,1),prior(1)],[P(2,2),prior(2)],'b-');
% plot([P(2,1),rear(1)],[P(2,2),rear(2)],'b-');
% 
% for i = 1:length(P) 
%     nxt = i + 1;
%     if i == 3
%         nxt = 1;
%     end
%     plot([P(i,1),P(nxt,1)],[P(i,2),P(nxt,2)],'g--o');
% end
% 
% for i = 1:length(smooth)-1
%     plot([smooth(i,1),smooth(i+1,1)],[smooth(i,2),smooth(i+1,2)],'r--');
% end
