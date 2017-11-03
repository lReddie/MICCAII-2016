function [G1, G2, G3, nIDK] = labelClusters(IDK)
% LABELCLUSTERS - labels the cluster
%   [G1, G2, G3] = labelClusters(IDK) labels the clusters in IDK with the
%   known knowledge.


healthy = [ 5 11 17 22 27];
cat1 = [ 3 10 16 20 26];
cat2 = [4 7 8 13 25];

G1.subjects = find(IDK==1);
G2.subjects = find(IDK==2);
G3.subjects = find(IDK==3);


G1.healthy =  length(intersect(G1.subjects,healthy));
G1.cat1 = length(intersect(G1.subjects,cat1));
G1.cat2 = length(intersect(G1.subjects,cat2));

G2.healthy =  length(intersect(G2.subjects,healthy));
G2.cat1 = length(intersect(G2.subjects,cat1));
G2.cat2 = length(intersect(G2.subjects,cat2));

G3.healthy =  length(intersect(G3.subjects,healthy));
G3.cat1 = length(intersect(G3.subjects,cat1));
G3.cat2 = length(intersect(G3.subjects,cat2));



Group{1} = G1;
Group{2} = G2;
Group{3} = G3;

[h, i] = max( [G1.healthy G2.healthy G3.healthy] );
[c1, i1] = max( [G1.cat1 G2.cat1 G3.cat1] );
[c2, i2] = max( [G1.cat2 G2.cat2 G3.cat2] );
Health = Group{i}; Categor1 = Group{i1}; Categor2 = Group{i2};


TnIDK = zeros(27,3);
for iter = Categor1.subjects
    TnIDK(iter,2) = 1;
end

for iter = Categor2.subjects
    TnIDK(iter,3) = 2;
end

nIDK = sum(TnIDK,2);

end




