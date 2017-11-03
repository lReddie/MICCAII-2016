function output = CreateStruct(Status, phrase)
% CREATESTRUCT - contains information of mtop's 27 subjects
%   output = CreateStruct(Status, phrase) returns a struct of 27 structs
%   containing the name, age, sex, cond (condition), num(number based on the
%   condition), connectivity(connectivity matrix, and axis(the labels of
%   the axis of the connectivity matrix)
%   i.e. H_sub = CreateStruct(cat1, '*qsdr.1.2*gfa.end.connectivity.mat')
%   loads healthy subjects onto a struct containing the connectivity matrix
%   of a qsdr.1.2 reconstruction and parameters of gfa and endtoend connectivity matrix 

sub{1}.name = 'sub01'; sub{1}.age = 49; sub{1}.sex ='female'; sub{1}.cond = 'unknown'; sub{1}.num = 99;
sub{2}.name = 'sub02'; sub{2}.age = 45; sub{2}.sex ='male'; sub{2}.cond = 'unknown'; sub{2}.num = 99;
sub{3}.name = 'sub03'; sub{3}.age = 46; sub{3}.sex ='male'; sub{3}.cond = 'cat1'; sub{3}.num = 1;
sub{4}.name = 'sub04'; sub{4}.age = 17; sub{4}.sex ='male'; sub{4}.cond = 'cat2'; sub{4}.num = 2;
sub{5}.name = 'sub05'; sub{5}.age = 40; sub{5}.sex ='male'; sub{5}.cond = 'healthy'; sub{5}.num = 0;
sub{6}.name = 'sub06'; sub{6}.age = 49; sub{6}.sex ='male'; sub{6}.cond = 'unknown'; sub{6}.num = 99;
sub{7}.name = 'sub07'; sub{7}.age = 69; sub{7}.sex ='male'; sub{7}.cond = 'cat2'; sub{7}.num = 2;
sub{8}.name = 'sub08'; sub{8}.age = 20; sub{8}.sex ='male'; sub{8}.cond = 'cat2'; sub{8}.num = 2;
sub{9}.name = 'sub09'; sub{9}.age = 19; sub{9}.sex ='male'; sub{9}.cond = 'unknown'; sub{9}.num = 99;
sub{10}.name = 'sub10'; sub{10}.age = 43; sub{10}.sex ='male'; sub{10}.cond = 'cat1'; sub{10}.num = 1;
sub{11}.name = 'sub11'; sub{11}.age = 30; sub{11}.sex ='female'; sub{11}.cond = 'healthy'; sub{11}.num = 0;
sub{12}.name = 'sub12'; sub{12}.age = 75; sub{12}.sex ='female'; sub{12}.cond = 'unknown'; sub{12}.num = 99;
sub{13}.name = 'sub13'; sub{13}.age = 21; sub{13}.sex ='female'; sub{13}.cond = 'cat2'; sub{13}.num = 2;
sub{14}.name = 'sub14'; sub{14}.age = 19; sub{14}.sex ='female'; sub{14}.cond = 'unknown'; sub{14}.num = 99;
sub{15}.name = 'sub15'; sub{15}.age = 36; sub{15}.sex ='female'; sub{15}.cond = 'unknown'; sub{15}.num = 99;
sub{16}.name = 'sub16'; sub{16}.age = 26; sub{16}.sex ='female'; sub{16}.cond = 'cat1'; sub{16}.num = 1;
sub{17}.name = 'sub17'; sub{17}.age = 29; sub{17}.sex ='male'; sub{17}.cond = 'healthy'; sub{17}.num = 0;
sub{18}.name = 'sub18'; sub{18}.age = 37; sub{18}.sex ='male'; sub{18}.cond = 'unknown'; sub{18}.num = 99;
sub{19}.name = 'sub19'; sub{19}.age = 74; sub{19}.sex ='female'; sub{19}.cond = 'unknown'; sub{19}.num = 99;
sub{20}.name = 'sub20'; sub{20}.age = 27; sub{20}.sex ='female'; sub{20}.cond = 'cat1'; sub{20}.num = 1;
sub{21}.name = 'sub21'; sub{21}.age = 28; sub{21}.sex ='female'; sub{21}.cond = 'unknown'; sub{21}.num = 99;
sub{22}.name = 'sub22'; sub{22}.age = 44; sub{22}.sex ='male'; sub{22}.cond = 'healthy'; sub{22}.num = 0;
sub{23}.name = 'sub23'; sub{23}.age = 46; sub{23}.sex ='female'; sub{23}.cond = 'unknown'; sub{23}.num = 99;
sub{24}.name = 'sub24'; sub{24}.age = 24; sub{24}.sex ='male'; sub{24}.cond = 'unknown'; sub{24}.num = 99;
sub{25}.name = 'sub25'; sub{25}.age = 18; sub{25}.sex ='male'; sub{25}.cond = 'cat2'; sub{25}.num = 2;
sub{26}.name = 'sub26'; sub{26}.age = 40; sub{26}.sex ='male'; sub{26}.cond = 'cat1'; sub{26}.num = 1;
sub{27}.name = 'sub27'; sub{27}.age = 48; sub{27}.sex ='female'; sub{27}.cond = 'healthy'; sub{27}.num = 0;


if ~exist('phrase') || isempty(phrase) 
    phrase = '*qsdr.1.2.1*.ncount.pass.connectivity.mat';
end

v = loadmatrices(phrase);
for i = 1:27
    for j =1:length(phrase)
        sub{i}.connectivity{j} = v{i}{j}.connectivity;
        sub{i}.labels{j} = v{i}{j}.name;
    end
   % sub{i}.axis = v{i}.name;
end
    


if ~exist('Status') || isempty(Status) || strcmp(Status, 'all')
    output = sub;

elseif strcmp(Status, 'cat1') || strcmp(Status, 'cat2') || strcmp(Status, 'healthy') || strcmp(Status, 'unknown')
    t = 1;
    for i = 1:27
        if strcmp(sub{i}.cond , Status )
            output{t} = sub{i};
            t = t+1;
        end
    end
     
elseif strcmp(Status, 'known') 
    t = 1;
    for i = 1:27
        if ~strcmp(sub{i}.cond , 'unknown')
            output{t} = sub{i};
            t = t+1;
        end
    end
    
elseif isnumeric(Status) && max(max(Status)) < 28 && min(min(Status)) > 0
    [a,b] = size(Status);
    reshape(Status, [a*b ,1]);
    Status = unique(Status);
    for i = 1:length(Status)
        output{i} = sub{Status(i)};
    end
    
else
    error('Error in CreateStruct.m \n Check Input')

end

