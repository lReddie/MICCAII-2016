function V = VisualizeMatrix(Struct)


NumbofSubs = length(Struct);
rows = sqrt(NumbofSubs);
cols = ceil(rows);
rows = round(rows);

Low = 0;
High = 0;
for i=1:NumbofSubs
    nH = max(max(Struct{i}.connectivity));
    if High < nH
        High = nH;
    end
end

for i =1:NumbofSubs
    subplot(rows,cols,i)
    imshow(Struct{i}.connectivity^2,[Low High])
    title(Struct{i}.name); ylabel(Struct{i}.cond)
end

end