function [Phrase nP] = createPhrases(recon, atlas,met,endorpass)

%{
if ~exist('recon') || isempty(recon) || strcmp(recon,'all')
    recon = {'qsdr','gqi','dti','dsi','qbi'};
end

if ~exist('atlas') || isempty(atlas) || strcmp(atlas,'all')
    atlas = {'aal','talairach'};
end

if ~exist('met') || isempty(met) || strcmp(met,'all')
    met = {'ncount','gfa','fa','nqa','adc','axial_dif','iso'};
end

if ~exist('endorpass') || isempty(endorpass) || strcmp(endorpass,'all')
    endorpass = {'pass','end'};
end

%}

%recon{ismember(recon,'qsdr')} = 'qsdr.1.2.1';
P = allcomb(recon, atlas,met,endorpass);
m = size(P,1);

for i=1:m
    if (strcmp(P{i,1},'gqi') || strcmp(P{i,1},'qsdr')|| strcmp(P{i,1},'dsi')|| strcmp(P{i,1},'qbi')) && (strcmp(P{i,3},'adc') || strcmp(P{i,3},'fa') || strcmp(P{i,3},'axial_dif'))
        
    elseif ((strcmp(P{i,3},'gfa') || strcmp(P{i,3},'nqa') || strcmp(P{i,3},'iso')) && strcmp(P{i,1},'dti'))
        
    else
        nP(i,:) = P(i,:);
    end
end

if exist('nP')
    nP(all(cellfun(@isempty,nP),2),:) = [];
    m = size(nP,1);
    for i = 1:m
        Phrase(i) = { ['*',nP{i,1},'*.' nP{i,2},'.',nP{i,3},'*', nP{i,4},'.connectivity.mat']  };
    end

else
    Phrase = 0;
    nP = 0;

end


end