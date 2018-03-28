function feature_vec = computeFeatures(src_folder)

files = dir(src_folder);
% Remove unwanted files from dir
files = files(~ismember({files.name},{'.','..','.DS_Store'}));
% Initialize feature vector
feature_vec = zeros(length(files),19);
% pixel to mm 
mm_per_pixel = 0.0706;

for i = 1:length(files)
    % Print image number
    i
    img = imread([files(i).folder filesep files(i).name]);
    % Get color channels
    r = img(:,:,1);
    g = img(:,:,2);
    b = img(:,:,3);
    
    % Find binary mask of image
    mask = r;
    mask(mask<= 6) = 0;
    mask(mask > 6) = 1;
    r = r.*mask;
    g = g.*mask;
    b = b.*mask;
    
    % Compute area, roundness, circularity
    feature_vec = shapeProperties(mask, feature_vec, i, mm_per_pixel);
    
    % Compute mean, standard deviation, and range of channels
    feature_vec = colorStatsRGB(r, g, b, feature_vec, i);
    feature_vec = colorStatsHSI(img, feature_vec, i);
    
    % Compute number of defects
    feature_vec = defectFinder(r, g, b, feature_vec, img,i, mask);
end
%save('feature_vec')
end