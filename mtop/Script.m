%%SCRIPT: TRAINING MTOP SUBJECTS
%_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
%   Uses code from ex7.m , ex7_pca

%{
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
%% RESET
%INITiALIZE
clear; close all; clc;

actualres = [NaN;NaN;1;2;0;NaN;2;2;NaN;1;0;NaN;NaN;2;NaN;1;0;NaN;NaN;1;NaN;0;NaN;NaN;2;1;0;];
GroundTruth = [1;2;0;2;2;1;0;2;1;0;1;0;2;1;0;];
%{'qsdr','dsi','dti','gqi','qbi'},{'talairach','aal'},{'ncount','gfa','fa','gfa','nqa','adc'},{'end'}
% qsdr dsi dti, talairach, ncount gfa, end
%% INITIALIZE
%Identify atlas and parameters
[phrase nP] = createPhrases({'qsdr','dsi'},{'talairach'},{'ncount','gfa'},{'end'});

% Load Subjects
all = CreateStruct('all', phrase);
fprintf('using %d subjects \n', length(all));

% Create Features
X = CreateFeatures(all, [1]);

% Normalize Date
[X_norm, mu, sigma] = featureNormalize(X);
%X_norm = [ones(size(X_norm ,1),1) X_norm];

%% KMEAN CLUSTER
%Set Initial number of centroids
%Distance - sqEuclidean , cityblock, correlation

[tIDK, Centroid, SUMD, Dist] = kmeans(X_norm, 3,'Distance','sqEuclidean', 'MaxIter', 1000);

[B1, B2, B3, IDK] = labelClusters(tIDK);
knownIDK = [IDK(3:5,:); IDK(7:8,:); IDK(10:11,:); IDK(14,:); IDK(16:17,:); IDK(20,:); IDK(22,:); IDK(25:27,:);];
PROB = IDKProb(Dist);
knownPROB = [PROB(3:5,:); PROB(7:8,:); PROB(10:11,:); PROB(14,:); PROB(16:17,:); PROB(20,:); PROB(22,:); PROB(25:27,:);];


%% RESULTS
COMPARE = [actualres IDK max(PROB,[],2)]
knownCOMPARE = [GroundTruth knownIDK max(knownPROB,[],2)]
NumberCorrect = length(find(GroundTruth == knownIDK))
ARI = rand_index(GroundTruth, knownIDK,'adjusted')
h = Homogeneity(GroundTruth,knownIDK)


%% SIZE CONSTRAINTS
[knownlabel unknownlabel bIDK] = balancelabel(Dist)
[B1, B2, B3, IDK] = labelClusters(bIDK);
knownIDK = [IDK(3:5,:); IDK(7:8,:); IDK(10:11,:); IDK(14,:); IDK(16:17,:); IDK(20,:); IDK(22,:); IDK(25:27,:);];
PROB = IDKProb(Dist);
knownPROB = [PROB(3:5,:); PROB(7:8,:); PROB(10:11,:); PROB(14,:); PROB(16:17,:); PROB(20,:); PROB(22,:); PROB(25:27,:);];


%% RESULTS
COMPARE = [actualres IDK max(PROB,[],2)]
knownCOMPARE = [GroundTruth knownIDK max(knownPROB,[],2)]
NumberCorrect = length(find(GroundTruth == knownIDK))
ARI = rand_index(GroundTruth, knownIDK,'adjusted')
h = Homogeneity(GroundTruth,knownIDK)
