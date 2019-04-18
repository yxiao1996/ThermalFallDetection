%% 3 Class KNN model classifying 3 postures
% 1 for standing, 2 for squatting and 3 for sitting
clear all
close all

walk = load("walk.mat");
squat = load("squat.mat");
fall = load("fall.mat");
trainRatio = 0.5;
k = 5;
%% prepare training data
class1 = shuffle(walk.walk);
class2 = shuffle(squat.squat);
class3 = shuffle(fall.fall);

numPoints = size(class1,1)+size(class2,1)+size(class3,1);
class1Ratio = size(class1,1) / numPoints;
class2Ratio = size(class2,1) / numPoints;
class3Ratio = size(class3,1) / numPoints;
nTrain = floor(numPoints*trainRatio);
nTest = floor(numPoints*(1-trainRatio));
nTrain1 = floor(nTrain*class1Ratio);
nTrain2 = floor(nTrain*class2Ratio);
nTrain3 = floor(nTrain*class3Ratio);
nTest1 = floor(nTest*class1Ratio);
nTest2 = floor(nTest*class2Ratio);
nTest3 = floor(nTest*class3Ratio);
train1 = class1(1:nTrain1,:,:,:);
train2 = class2(1:nTrain2,:,:,:);
train3 = class3(1:nTrain3,:,:,:);

cov1 = groupCov(train1);
cov2 = groupCov(train2); % [n,3,3]
cov3 = groupCov(train3);
%% Build Multi-class KNN model
train = cell(3,1);
train{1} = cov1;
train{2} = cov2;
train{3} = cov3;
model = knnMultiClass(k,3,train);
%% prepare test data
test1 = class1(nTrain1:nTrain1+nTest1,:,:,:);
test2 = class2(nTrain2:nTrain2+nTest2,:,:,:);
test3 = class3(nTrain3:nTrain3+nTest3,:,:,:);

c_1 = groupCov(test1);
c_2 = groupCov(test2);
c_3 = groupCov(test3);
%% Test model
test = cell(3,1);
test{1} = c_1;
test{2} = c_2;
test{3} = c_3;

disp("Accuracy and Confusion Matrix of test data");
[acc,cm] = model.ConfusionMatrix(test);
disp(acc);
disp(cm);

%% helper function
function covs = groupCov(data)
    numSeq = size(data,1);
    covs = zeros(numSeq,13,13);
    for i = 1:numSeq
        seq = squeeze(data(i,:,:,:));
        covs(i,:,:) = silhouetteTunnelCovariance(seq);
    end
end