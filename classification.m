function C = classification()

%% Training: load training set and train classifier
load('feature_vec_labels_train.mat');
% predictors: 
% values of 10th feature was the same for all observations and classes, so
% the 10th feature is dropped from consideration
X = feature_vec_labels(:,[1:9 11:24]);
% labels
Y = feature_vec_labels(:,25);
labels = {'discount', 'sell', 'throwaway'};
L = labels(Y)';

% split into training & validation sets
% 70% for train, 30% for validation
[train_ind, valid_ind] = crossvalind('HoldOut', L, 0.3);
train = feature_vec_labels(train_ind(:,1)==1,:);
train_X = X(train_ind(:,1)==1,:);
train_L = L(train_ind(:,1)==1,:);
valid = feature_vec_labels(valid_ind(:,1)==1,:);
valid_X = valid(:,1:24);
valid_L = valid(:,25);

%% Feature Selection: relieff and (forward) sequential feature selection
%% relieff: using 10 nearest neighbors
% note: since feature 10 was dropped, original feature 11 is now feature
% 10, original feature 12 is now feature 11, etc.
[ranks,weights] = relieff(train_X,train_L,10,'method','classification');
bar(weights)
xlabel('Feature')
ylabel('Feature importance weight')
ranks(1:10)
%% Sequential feature selection
% metric: misclassification error = # misclassified obs / # obs
fun = @(XT,yT,Xt,yt)...
      (sum(~strcmp(yt,classify(Xt,XT,yT,'quadratic'))));
% Leave one out CV: since dataset is small, but more computationally expensive
c = cvpartition(train_L,'LeaveOut');
opts = statset('display','iter');
[fs,history] = sequentialfs(fun,train_X,train_L,'cv',c,'options',opts)

%% Comparing Models with Validation Set
[trainedFS, ~] = trainClassifierFS(train);
[trainedNoFS, ~] = trainClassifierNoFS(train);

pred_FS = trainedFS.predictFcn(valid_X);
confusionmat(valid_L,pred_FS)
pred_noFS = trainedNoFS.predictFcn(valid_X);
confusionmat(valid_L,pred_noFS)


%% Testing: load testing set and predict
load('feature_vec_labels_test.mat');
% Separate predictor columns from labels 
test_Y = feature_vec_labels(:,25);
test_X = feature_vec_labels(:,1:24);

% Predict
predicted = trainedFS.predictFcn(test_X);

%% Confusion Matrix
C = confusionmat(test_Y,predicted);