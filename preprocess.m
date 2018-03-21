close all;
src_folder = '/Users/Heather/Documents/Orange Photos/';
dest_folder = '/Users/Heather/Documents/Orange Photos Edited/';
files = dir(src_folder);
mm_per_pixel = 0.0706;
for i = 1:length(files)
    i
    if contains(files(i).name, 'JPG')
        img = imread([files(i).folder filesep files(i).name]);
        r = img(:,:,1);
        g = img(:,:,2);

        % Get mask from red channel
        mask = r;
        mask(mask < 70) = 0;
        mask(mask ~= 0) = 1;
        mask = bwareaopen(mask,200);
        img = img(:,:,:) .* uint8(mask);

        % Find center to use for cropping
        measurements = regionprops(mask, 'centroid');
        col_center = round(measurements.Centroid(1));
        row_center = round(measurements.Centroid(2));
        % Crop image 500 pixels on each side of center pixel
        img = img(row_center-500:row_center+500, col_center-500:col_center+500,:);
        imwrite(img,[dest_folder files(i).name])
    end
end