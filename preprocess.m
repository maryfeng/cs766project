close all;
files = dir('/Users/Heather/Documents/Orange Photos/');
mm_per_pixel = 0.0706;
for i = 1:length(files)
    i
    if contains(files(i).name, 'JPG')
        img = imread([files(i).folder filesep files(i).name]);
        %img = imresize(img, 0.5);
        r = img(:,:,1);
        g = img(:,:,2);
        b = img(:,:,3);
%         figure;
%         subplot(1,3,1); imshow(r);
%         subplot(1,3,2); imshow(g); 
%         subplot(1,3,3); imshow(b);
        mask = r;
        mask(mask < 70) = 0;
        mask(mask ~= 0) = 1;
        mask = bwareaopen(mask,200);
        img = img(:,:,:) .* uint8(mask);


        measurements = regionprops(mask, 'centroid', 'MajorAxisLength',...
            'MinorAxisLength', 'area');
%         area = measurements.Area * mm_per_pixel^2;
%         diam = measurements.MajorAxisLength * mm_per_pixel;
        col_center = round(measurements.Centroid(1));
        row_center = round(measurements.Centroid(2));
        img = img(row_center-500:row_center+500, col_center-500:col_center+500,:);
        %figure; imshow(img)
        imwrite(img,['/Users/Heather/Documents/Orange Photos Edited/' files(i).name])
    end
end