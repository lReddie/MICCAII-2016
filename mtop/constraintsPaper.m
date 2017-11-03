function [A, U] = constraintsPaper(IDK)
% CONSTRAINTSPAPER - Forms the matrices described in clustering with constraints

G1 = length(find(IDK == 1));
G2 = length(find(IDK == 2));
G3 = length(find(IDK == 3));
Da = diag([G1 G2 G3]);

A = zeros(27,3);
for i = 1:27
    A(i,IDK(i)) = 1;
end

U = A*Da^(-1/2);


end