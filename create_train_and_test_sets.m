%% Used to generate final train and test set by sampling data
folder = '/Users/Heather/Google Drive/CS 766 Project/Graded_Oranges_3_classes/sell/';
files = dir(fullfile(folder, '*.jpg'));

x = randsample(length(files), 40);
train_folder = '/Users/Heather/Google Drive/CS 766 Project/New train and test sets/train/sell';
test_folder = '/Users/Heather/Google Drive/CS 766 Project/New train and test sets/test/sell';

for i = 1:length(files)
    src = fullfile(files(i).folder, files(i).name); 
   if ismember(i, x)
       dest = fullfile(train_folder, files(i).name);
       copyfile(src, dest)
   else
      dest =  fullfile(test_folder, files(i).name);
      copyfile(src, dest)
   end
    
end