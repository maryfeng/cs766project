%% Remove background and crop orange photos
close all;
src_folder = '/Users/Heather/Desktop/photos/';
dest_folder = '/Users/Heather/Desktop/photos edited/';
files = dir(src_folder);
mm_per_pixel = 0.0706;
for i = 1:length(files)
    i
    if contains(files(i).name, 'JPG')
        img = imread([files(i).folder filesep files(i).name]);
        r = img(:,:,1); %red channel
       
        % Get mask from red channel
        mask = r;
        % Binarize red channel to create mask
        mask(mask < 70) = 0;
        mask(mask ~= 0) = 1;
        mask = bwareaopen(mask,200);
        mask = bwareafilt(mask,1); % Take largest component only
        % Apply mask to image
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