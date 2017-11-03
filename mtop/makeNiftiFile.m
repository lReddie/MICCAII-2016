function makeNiftiFile(STRUCT)

n = numel(STRUCT)

for 1:n
    save_nii(make_nii(STRUCT{i}), ('roi%i.nii', i))
end