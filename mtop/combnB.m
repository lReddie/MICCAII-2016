function B = combnB(iter)
% COMBNB - returns iter amount of combinations of a 27 * 1 matrix
%   The matrix it returns are combinations of [1 1 1 1 1 1 1 1 1 2 2 2 2 2
%   2 2 2 2 3 3 3 3 3 3 3 3 3];

X = ones(1,27);
X(1:9) = 2;
X(10:18) =3;



if ~exist('iter') || isempty(iter)
    iter = 100000;
end

B = zeros(iter,27);
for i =1:iter
    B(i,:) = X(:,randperm(size(X, 2)));
end

end
