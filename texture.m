function feature_vec = texture(feature_vec, img, i)

% Texture properties
% 20. Entropy
% 21. Contrast
% 22. Correlation
% 23. Energy
% 24. Homogeneity

gray = rgb2gray(img);
% get rid of empty space
gray(~any(gray,2),:) = [];
gray(:,~any(gray,1)) = [];

% four directions, with offset of 5
% degrees from pixel of interest: [0; 45; 90; 135]
offsets = [0 5; -5 5;-5 0;-5 -5];
glcm = graycomatrix(gray,'Offset',offsets);
stats = graycoprops(glcm);

feature_vec(i,20) = entropy(gray);
feature_vec(i,21) = mean(stats.Contrast);
feature_vec(i,22) = mean(stats.Correlation);
feature_vec(i,23) = mean(stats.Energy);
feature_vec(i,24) = mean(stats.Homogeneity);
end