folder = uigetdir();
files = dir(folder);

for i = 1:length(files)
    i
    if contains(files(i).name, 'JPG')
        img = imread([files(i).folder filesep files(i).name]);
        r = img(:,:,1);
        g = img(:,:,2);
        b = img(:,:,3);
        
        figure;
        subplot(1,4,1); imshow(r);
        subplot(1,4,2); imshow(g);
        subplot(1,4,3); imshow(b);
        subplot(1,4,4); imshow(img);
    end
end