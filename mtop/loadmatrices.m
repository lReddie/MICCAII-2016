function sub = loadmatrices(phrase, BaseDir)
% LOADMATRICES - loads the connectivity matrix from Directory
%   sub = loadmatrices(phrase, BaseDir) returns a struct of the subjects
%   matrix based on the phrase from BaseDir.
%   i.e. sub = loadmatrices('*.fa.end.connectvity.mat') will load matrix of
%   parameters of fa and endtoend

mainFolder = cd;
if ~exist('BaseDir') || isempty(BaseDir)
    folder = 'reconmat';
    mainFolder = 'C:\Program Files (x86)\MATLAB\R2013a Student\bin';
    cd ([mainFolder '\' folder]);
    BaseDir = cd;
end

folders = ls;
numFolders = length(folders);
features = length(phrase);

for i=3:numFolders
    SubDir = ([BaseDir '\' folders(i,:)]);
    for j =1:length(phrase)
        %p = cell2mat(phrase{j});
        file = dir( fullfile(SubDir, phrase{j}) );
        file = {file.name};
        fname = fullfile(SubDir, file{1});
        sub{i-2}{j} = load(fname);
    end
    cd(BaseDir);
end

%cd(mainFolder);

end





