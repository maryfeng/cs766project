dirs = dir('Graded_Oranges');
dirs = dirs(~ismember({dirs.name},{'.','..','.DS_Store'}));
feature_vecs = cell(length(dirs),1);

for i = 1:length(dirs)
    feature_vecs{i} = computeFeatures([dirs(i).folder filesep dirs(i).name]);
    % add label
    feature_vecs{i}(:,20) = i;
end

feature_vec_labels = cat(1,feature_vecs{:});
save('feature_vec_labels','feature_vec_labels')