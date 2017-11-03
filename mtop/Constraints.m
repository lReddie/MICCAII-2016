function RESULT = Constraints(IDKorDIST, possibleIDK)
% CONSTRAINTS - returns the result of an IDK with constraints on them
%   The first input is the IDK or Dist returned from kmeans
%   The second input is a matrix of the possibleIDK returned from combnB.m

if size(IDKorDIST,2) >= 2
    min = inf;
    for i =1:size(possibleIDK,1)
        L = constraintsPaper(possibleIDK(i,:));
        temp = sum(sum(IDKorDIST .* L));
        if temp < min
            min = temp;
            RESULT = L;
        end
    end
    
else
    [A, U] = constraintsPaper(IDKorDIST);
    min = inf;
    for i =1:size(possibleIDK,1)
        [B, V]= constraintsPaper(possibleIDK(i,:));
        temp = sum(sum(U .* V));
        if temp < min
            min = temp;
            RESULT = B;
        end
    end
    
end

end
