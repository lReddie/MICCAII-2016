
clear; clc

n = [1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3];


p =combn([1 0 0],3);

%for i =1:length(p)
 %   if length(find(p(i,:)==1)