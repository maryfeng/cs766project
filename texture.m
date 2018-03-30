function feature_vec = texture(feature_vec, img, i)

% Texture properties
% 20. Entropy
% 21. Contrast
% 22. Correlation
% 23. Energy
% 24. Homogeneity

% specify different offset/pixel spatial relationship?
gray = rgb2gray(img);
glcm = graycomatrix(gray);
stats = graycoprops(glcm);

feature_vec(i,20) = entropy(gray);
feature_vec(i,21) = stats.Contrast;
feature_vec(i,22) = stats.Correlation;
feature_vec(i,23) = stats.Energy;
feature_vec(i,24) = stats.Homogeneity;

end

