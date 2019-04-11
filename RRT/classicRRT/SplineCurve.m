p = [[10,10]; [16,23]; [30,15]];
prior = 2 .* p(1,:) - p(2,:);
rear = 2 .* p(3,:) - p(2,:);

num_control = length(p);

q = double.empty(0,2);

for i = 1:num_control-1
    for t = 0:0.1:1
        tmp = p(i,:)*(1-t) + p(i+1,:)*t;
        q = [q;tmp];
    end
end


figure;
hold on;
for i = 1 : length(p)
    plot(p(i,1),p(i,2),'r*');
end

plot([prior(1),p(2,1)],[prior(2),p(2,2)],'r--');
plot([rear(1),p(2,1)],[rear(2),p(2,2)],'r--');

for i = 1:length(q)/2
    delta = length(0:0.1:1);
    plot([q(i,1), q(i+delta,1)],[q(i,2), q(i+delta,2)],'b-o');
end