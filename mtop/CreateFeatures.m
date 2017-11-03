function X = CreateFeatures(subject, Degree)
% CREATEFEATURES - sums the connection of the matrix
%   X = CreateFeatures(subject, Degree) returns a matrix
%   that is the (number of subjects) by (Degree * length(connectivity_matrix))
%   The Degree is a positive integer and determines the size of the polynomial.
%   subject is a struct formed by CreateStruct.m

if ~exist('Degree') || isempty(Degree)
    Degree = 1;
end

sublen = length(subject);

length_mat = length(subject{1}.connectivity);

for i = 2:sublen
    if length(subject{i}.connectivity) ~= length_mat
        error('missing matrix for subject %d', i)
    end
end

jk = 0;
for i=1:length_mat
    jk = jk + length(subject{1}.connectivity{i});
end

feat = zeros(sublen,jk, length(Degree));

for i=1:sublen
    for j=1:length_mat
        for k = 1:length(Degree)
            feat(i,(j-1)*length(subject{i}.connectivity{j})+1:j*length(subject{i}.connectivity{j}),k) = sum(subject{i}.connectivity{j}^Degree(k));
        end
    end
end

X = feat(:,:,1);

if length(Degree) > 1
    for d=2:Degree
        X = [X feat(:,:,d)];
    end
end

for i = 1:sublen
    age(i,1) = getfield(subject{i},'age');
end
X = [X age];




end