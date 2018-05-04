%% Feature Selection: relieff and (forward) sequential feature selection

% predictors: 
% values of 10th feature was the same for all observations and classes, so
% the 10th feature is dropped from consideration
X = feature_vec_labels(:,[1:9 11:24]);
% labels
Y = feature_vec_labels(:,25);
labels = {'discount', 'sell', 'throwaway'};
L = labels(Y)';

%% relieff: using 10 nearest neighbors
% note: since feature 10 was dropped, original feature 11 is now feature
% 10, original feature 12 is now feature 11, etc.
[ranks,weights] = relieff(X,L,10,'method','classification');
bar(weights)
xlabel('Feature')
ylabel('Feature importance weight')
ranks(1:10)

%% Sequential feature selection
% metric: misclassification error = # misclassified obs / # obs
fun = @(XT,yT,Xt,yt)...
      (sum(~strcmp(yt,classify(Xt,XT,yT,'quadratic'))));
% Leave one out CV: since dataset is small, but more computationally expensive
c = cvpartition(L,'LeaveOut');
opts = statset('display','iter');

[fs,history] = sequentialfs(fun,X,L,'cv',c,'options',opts)