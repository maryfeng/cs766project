dirs = dir('Graded Oranges Resized');
dirs = dirs(~ismember({dirs.name},{'.','..','.DS_Store'}));
feature_vecs = cell(length(dirs),1);

for i = 1:length(dirs)
    feature_vecs{i} = getFeats([dirs(i).folder filesep dirs(i).name]);
end

feature_vec = cat(1,feature_vecs{:});
save('feature_vec')