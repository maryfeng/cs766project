% Resize images to work for alexnet 
src_folder = '/Users/Heather/Google Drive/CS 766 Project/Train and test for CNN/test/sell';
dest_folder = '/Users/Heather/Google Drive/CS 766 Project/Train and test for CNN/resize_test/sell';

files = dir(src_folder);
for i = 1:length(files)
    if contains(files(i).name, 'JPG')
        img = imread([files(i).folder filesep files(i).name]);
        img = imresize(img, [227 227]);
        imwrite(img,[dest_folder filesep files(i).name])

    end
end