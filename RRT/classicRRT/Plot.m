fig = figure;
imshow(map);
hold on;

plot(q_start(1),q_start(2),'r*', 'MarkerSize', 10);
plot(q_goal(1),q_goal(2),'r*', 'MarkerSize', 10);

% for i = 2 : size(vertices)-1
%     plot(vertices(i,1), vertices(i,2), 'b*');
% end
cRRT = 'classicRRT.gif';
for i = 1: 2 : size(edge)
    plot([edge(i,1),edge(i+1,1)],[edge(i,2),edge(i+1,2)],'dg--');
    pause(0.025);
    frame = getframe(fig);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);
    
    if i == 1
        imwrite(imind,cm,cRRT,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,cRRT,'gif', 'WriteMode','append');
    end
%     drawnow
end
 
% writeObj = VideoWriter('classicRRT.avi');
% writeObj.FrameRate = 10;
% [writeObj.Height, writeObj.Width] = size(fig);
% 
% open(writeObj);
% for i = 1:length(F)
%     frame = F(i);
%     size(frame.cdata)
%     writeVideo(writeObj, frame);
% end
% close(writeObj)

clear writeObj;
