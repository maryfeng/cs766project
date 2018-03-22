src_folder = '/Users/Heather/Documents/Graded Oranges/US No 4';
dest_folder = '/Users/Heather/Documents/Graded Oranges Resized/US No 4'

files = dir(src_folder);
for i = 1:length(files)
    if contains(files(i).name, 'JPG')
        img = imread([files(i).folder filesep files(i).name]);
        img = imresize(img, [227 227]);
        imwrite(img,[dest_folder filesep files(i).name])

    end
end