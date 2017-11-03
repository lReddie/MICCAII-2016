function [klabel ulabel IDK] = balancelabel(distance)

if size(distance,1) ~= 27
    error('wrong size of Dist')
else
    
cluster = size(distance,2);

D1 = [distance(3:5,:); distance(7:8,:);...
    distance(10:11,:); distance(14,:);...
    distance(16:17,:); distance(20,:);...
    distance(22,:); distance(25:27,:);];

num1 = size(D1,1);
min_D1  = sum(max(D1,[],2));

D2 = [distance(1:2,:); distance(6,:);...
    distance(9,:); distance(12:13,:);...
    distance(15,:); distance(18:19,:);...
    distance(21,:); distance(23:24,:);];
num2 = size(D2,1);
min_D2 = sum(max(D2,[],2));


c1= nchoosek(1:num1,num1/cluster);

if num1 == 15
    remaining1 = zeros(10,1);
    class3 = zeros(1,5);
    riter = 1;
    riter2 = 1;
   for class1iter = 1:length(c1)
       class1 = c1(class1iter,:);
       for i = 1:num1
           if ismember(i,class1)== 0;
               remaining1(riter) = i;
               riter = riter+1;
           end
       end
       c2 = nchoosek(remaining1, num1/cluster);
       for class2iter = 1:length(c2)
           class2 = c2(class2iter,:);
           for j = 1:num1
               if ismember(j,class1)==0 && ismember(j,class2)==0
                   class3(riter2) = j;
                   riter2 = riter2 +1;
               end
           end
               Dclass1 = D1(class1(1),1)+ D1(class1(2),1)+ D1(class1(3),1)+ D1(class1(4),1) + D1(class1(5),1);
               Dclass2 = D1(class2(1),2)+ D1(class2(2),2)+ D1(class2(3),2)+ D1(class2(4),2) + D1(class2(5),2);
               Dclass3 = D1(class3(1),3)+ D1(class3(2),3)+ D1(class3(3),3)+ D1(class3(4),3) + D1(class3(5),3);

               tmp = Dclass1 + Dclass2 + Dclass3;
               if tmp <= min_D1
                   min_D1 = tmp;
                   klabel0 = class1;
                   klabel1 = class2;
                   klabel2 = class3;
               end
        end
   end
end

klabel = zeros(15,1)
for i = 1:15
    if ismember(i,klabel1)
        klabel(i) = 1;
    elseif ismember(i, klabel2)
        klabel(i) = 2;
    end
end


f1= nchoosek(1:num2,num2/cluster);

if num2 == 12
    remaining1 = zeros(8,1);
    class3 = zeros(1,3);
    riter = 1;
    riter2 = 1;
   for class1iter = 1:length(f1)
       class1 = f1(class1iter,:);
       for i = 1:num2
           if ismember(i,class1)== 0;
               remaining1(riter) = i;
               riter = riter+1;
           end
       end
       c2 = nchoosek(remaining1, num2/cluster);
       for class2iter = 1:length(c2)
           class2 = c2(class2iter,:);
           for j = 1:num2
               if ismember(j,class1)==0 && ismember(j,class2)==0
                   class3(riter2) = j;
                   riter2 = riter2 +1;
               end
           end
               Dclass1 = D2(class1(1),1)+ D2(class1(2),1)+ D2(class1(3),1);
               Dclass2 = D2(class2(1),2)+ D2(class2(2),2)+ D2(class2(3),2);
               Dclass3 = D2(class3(1),3)+ D2(class3(2),3)+ D2(class3(3),3);

               tmp = Dclass1 + Dclass2 + Dclass3;
               if tmp <= min_D2
                   min_D2 = tmp;
                   ulabel0 = class1;
                   ulabel1 = class2;
                   ulabel2 = class3;
               end
        end
   end
end
                    
ulabel = zeros(12,1)
for i = 1:12
    if ismember(i,ulabel1)
        ulabel(i) = 1;
    elseif ismember(i, ulabel2)
        ulabel(i) = 2;
    end
end


IDK = [ulabel(1:2); klabel(1:3); ulabel(3); klabel(4:5);...
    ulabel(4); klabel(6:7); ulabel(5:6); klabel(8);... 
    ulabel(7) klabel(9:10); ulabel(8:9); klabel(11);...
    ulabel(10); klabel(12); ulable(11:12); klabel(13:15)];    
    
    
    
end
%}