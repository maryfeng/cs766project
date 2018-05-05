% Create image datastore
imds = imageDatastore('/Users/Heather/Google Drive/CS 766 Project/Train and test for CNN/resize_train',...
    'IncludeSubfolders', true, 'LabelSource', 'foldernames');
% 70/30 train/test 
[imdsTrain, imdsValidation] = splitEachLabel(imds, 0.7, 'randomized');
numTrainImages = numel(imdsTrain.Labels);
% Initialize alexnet
net = alexnet;
numClasses = numel(categories(imdsTrain.Labels));
% Initialize transfer learning
layersTransfer = net.Layers(1:end-3);
inputSize = net.Layers(1).InputSize;
layers = [
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];
% Training options
options = trainingOptions('sgdm', ...
    'MiniBatchSize',10, ...
    'MaxEpochs',10, ...
    'InitialLearnRate',1e-4, ...
    'ValidationData',imdsValidation, ...
    'LearnRateSchedule','piecewise',...
    'LearnRateDropFactor',0.2,...
    'LearnRateDropPeriod',5,...
    'ValidationFrequency',5, ...
    'ValidationPatience',Inf, ...
    'Verbose',false, ...
    'Plots','training-progress');
% Train network
netTransfer = trainNetwork(imdsTrain,layers,options);