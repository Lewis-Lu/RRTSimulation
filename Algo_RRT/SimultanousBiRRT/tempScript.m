
a = [];
time = [];
clear;
iter = 500;

for i = 1:iter
    simulbiRRT;
end

success = length(find(a == 1));
success_rate = success / iter;
