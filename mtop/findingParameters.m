function [param1, param2, param3, param4] = findingParameters()



t1 = {'qbi','gqi','qsdr','dsi','dti'};
t2 = {'aal', 'talairach'};
t3 = {'ncount','gfa','iso','nqa','fa', 'axial_dif', 'adc'};
t4 = {'end' , 'pass'};

lt1 = length(t1);
lt3 = length(t3);


for i = 1:lt1
    p1{i} = nchoosek(t1,i);
end

for i = 1:lt3
    p3{i} = nchoosek(t3,i);
end


iter = 1;
for j = 1:length(p1)
    for k =1:size(p1{j},1)
        param1{iter} = p1{j}(k,:);
        %param3{iter} = p3{j}(k,:);
        iter = iter+1;
    end
end

iter2 = 1;
for j = 1:length(p3)
    for k =1:size(p3{j},1)
        param3{iter2} = p3{j}(k,:);
        %param3{iter} = p3{j}(k,:);
        iter2 = iter2+1;
    end
end


%{
iter2 = 1;
for j = 1:length(p3)
    for k =1:size(p3{j},1)
        param3{iter2} = p3{j}(k,:);
        iter2 = iter2+1;
    end
end
%}

param2 = {t2(1) t2(2)};
param4 = {t4(1) t4(2) t4};

end