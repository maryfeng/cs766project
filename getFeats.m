function feature_vec = getFeats(src_folder)

files = dir(src_folder);
files = files(~ismember({files.name},{'.','..'}));
mm_per_pixel = 0.0706;

% Initialize feature vector
feature_vec = zeros(length(files),19);
% 1. Area
% 2. Circularity
% 3. Diameter
% 4. Mean R channel intensity
% 5. Mean G channel intensity 
% 6. Mean B channel intensity
% 7. Standard deviation of R channel
% 8. Standard deviation of G channel
% 9. Standard deviation of B channel
% 10. Range of R channel
% 11. Range of G channel
% 12. Range of B channel
% 13. Mean of Hue (H)
% 14. Mean of Saturation (S)
% 15. Mean of Intensity (I)
% 16. Standard deviation of Hue (H)
% 17. Standard deviation of Saturation (S)
% 18. Standard deviation of Intensity (I)
% 19. Percentage of blemished skin 

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
        feature_vec = defectFinder(r, g, b, feature_vec, img,i, mask);


    end
    %save('feature_vec')
end
end
