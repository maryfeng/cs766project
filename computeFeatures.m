close all;
files = dir('/Users/Heather/Documents/Orange Photos Edited/');
mm_per_pixel = 0.0706;
%% Find optimal parameters
im = imread('/Users/Heather/Documents/Orange Photos Edited/DSC_7157.JPG');
r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);
avg_r = mean(r(r~=0));
avg_g = mean(g(g~=0));
avg_b = mean(b(b~=0));

figure;
subplot(1,4,1); imshow(r);
subplot(1,4,2); imshow(g);
subplot(1,4,3); imshow(b);
subplot(1,4,4); imshow(im);
for i = 1:length(files)
    i
    if contains(files(i).name, 'JPG')
        img = imread([files(i).folder filesep files(i).name]);
        %img = imresize(img, 0.5);
        r = img(:,:,1);
        g = img(:,:,2);
        b = img(:,:,3);
%         figure;
%         subplot(1,4,1); imshow(r);
%         subplot(1,4,2); imshow(g); 
%         subplot(1,4,3); imshow(b);
%         subplot(1,4,4); imshow(img);
%         i
%         close;
        mask = r;
        mask(mask < 70) = 0;
        mask(mask ~= 0) = 1;
        mask = bwareaopen(mask,200);
%         img = img(:,:,:) .* uint8(mask);
% 
        perim = bwperim(mask);
        measurements = regionprops(mask, 'centroid', 'MajorAxisLength',...
            'MinorAxisLength', 'area');
        circularity = (sum(perim(:))^2)/(4*pi*measurements.Area);
        roundness = measurements.MinorAxisLength/measurements.MajorAxisLength;
        area = measurements.Area * mm_per_pixel^2;
        diam = measurements.MajorAxisLength * mm_per_pixel;

    end
end