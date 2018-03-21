src_folder = '/Users/Heather/Documents/Orange Photos Edited/';
files = dir(src_folder);
mm_per_pixel = 0.0706;

% Initialize feature vector
feature_vec = zeros(length(files),20);
% 1. Area
% 2. Roundness
% 3. Circularity
% 4. Diameter
% 5. Mean R channel intensity
% 6. Mean G channel intensity 
% 7. Mean B channel intensity
% 8. Standard deviation of R channel
% 9. Standard deviation of G channel
% 10. Standard deviation of B channel
% 11. Range of R channel
% 12. Range of G channel
% 13. Range of B channel
% 14. Mean of Hue (H)
% 15. Mean of Saturation (S)
% 16. Mean of Intensity (I)
% 17. Standard deviation of Hue (H)
% 18. Standard deviation of Saturation (S)
% 19. Standard deviation of Intensity (I)
% 20. Number of blemishes
% 21. Average size of blemishes

for i = 1:length(files)
    % Print image number
    i
    if contains(files(i).name, 'JPG')
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
        feature_vec = defectFinder(r, g, b, feature_vec, img,i);


    end
end