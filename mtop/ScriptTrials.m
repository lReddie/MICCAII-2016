%%SCRIPT: TRAINING MTOP SUBJECTS
%{
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
%   Uses code from ex7.m , ex7_pca
%
% CREATESTRUCT - contains information of all mtop's 27 subjects
%   output = CreateStruct(Status, phrase) returns a struct of 27 structs
%   containing the name, age, sex, cond (condition), num(number based on the
%   condition), connectivity(connectivity matrix, and axis(the labels of
%   the axis of the connectivity matrix)    
%
% CREATEFEATURES - sums the connection of the matrix
%   X = CreateFeatures(subject, Degree) returns a matrix
%   that is the (number of subjects) by (Degree * length(connectivity_matrix))
%   The Degree is a positive integer and determines the size of the polynomial.
%   subject is a struct formed by CreateStruct.m
%
% LOADMATRICES - loads the connectivity matrix from Directory
%   sub = loadmatrices(phrase, BaseDir) returns a struct of the subjects
%   matrix based on the phrase from BaseDir.
%   i.e. sub = loadmatrices('*.fa.end.connectvity.mat') will load matrix of
%   parameters of fa and endtoend
%
% COMBNB - returns iter amount of combinations of a 27 * 1 matrix
%   The matrix it returns are combinations of [1 1 1 1 1 1 1 1 1 2 2 2 2 2
%   2 2 2 2 3 3 3 3 3 3 3 3 3];
%
% CONSTRAINTS - returns the result of an IDK with constraints on them
%   The first input is the IDK or Dist returned from kmeans
%   The second input is a matrix of the possibleIDK returned from combnB.m
%
% CONSTRAINEDIDK - Takes 2D IDK and minimizes it to 1D
%
% LABELCLUSTERS - labels the cluster
%   [G1, G2, G3] = labelClusters(IDK) labels the clusters in IDK with the
%   known knowledge.
 %}
%% =======================Reset================
%INITiALIZE
clear; close all; clc;
actualres = [NaN;NaN;1;2;0;NaN;2;2;NaN;1;0;NaN;NaN;2;NaN;1;0;NaN;NaN;1;NaN;0;NaN;NaN;2;1;0;];

%% ===================== PART1: INITIALIZE======
%Identify atlas and parameters
iter =1;
[p1, p2, p3, p4] = findingParameters;
%[phrase nP] = createPhrases({'qsdr','dsi'},{'talairach'},{'ncount','gfa'},{'end'});
 
for a = 1:length(p1)
    for b = 1:length(p2)
        for c = 1:length(p3)
            for d = 1:length(p4)
                [phrase, np] = createPhrases(p1{a},p2{b},p3{c},p4{d});
                %Load Subjects
                all = CreateStruct('all', phrase);
                X = CreateFeatures(all, [1]);
                [X_norm, mu, sigma] = featureNormalize(X);
                [IDK, Centroid, SUMD, Dist] = kmeans(X_norm, 3,'Distance','sqEuclidean', 'MaxIter', 1000);
                [B1, B2, B3 tIDK] = labelClusters(IDK);    
                if ((B1.healthy >=4 && B2.cat1 >= 4 && B3.cat2 >= 4) || ...
                        (B1.healthy >=4 && B3.cat1 >= 4 && B2.cat2 >= 4) || ...
                        (B2.healthy >=4 && B1.cat1 >= 4 && B3.cat2 >= 4) || ...
                        (B2.healthy >=4 && B3.cat1 >= 4 && B1.cat2 >= 4) || ...
                        (B3.healthy >=4 && B1.cat1 >= 4 && B2.cat2 >= 4) || ...
                        (B3.healthy >=4 && B2.cat1 >= 4 && B1.cat2 >= 4)) && ... 
                        (var([length(B1.subjects) length(B2.subjects) length(B3.subjects)]) <= 1)
                    
                    nA{iter} = p1{a};
                    nB{iter} = p2{b};
                    nC{iter} = p3{c};
                    nD{iter} = p4{d};
                    nIDK(:,iter) = IDK;
                    fprintf('found %d \n', iter);
                    iter = iter + 1;
                end
 
            end
        end
    end
end
%% =================== PART: SIZE CONSTRAINTS
%{
possibleIDK = combnB(1000000);
result = Constraints(Dist, possibleIDK);
 
nIDK = constrainedIDK(result);
 
[G1 G2 G3] = labelClusters(nIDK)
%}    
    
  
   
