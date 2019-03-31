%% 3 Class KNN model classifying 3 postures
% 1 for standing, 2 for squatting and 3 for sitting
clear all
close all

walk = load("walk.mat");
squat = load("squat.mat");
fall = load("fall.mat");
trainRatio = 0.8;
k = 5;
%% prepare training data
class1 = SeqsToFrames(walk.walk);
class2 = SeqsToFrames(squat.squat);
class3 = SeqsToFrames(fall.fall);
class1 = shuffle(class1);
class2 = shuffle(class2);
class3 = shuffle(class3);

numPoints = size(class1,1)+size(class2,1)+size(class3,1);
class1Ratio = size(class1,1) / numPoints;
class2Ratio = size(class2,1) / numPoints;
class3Ratio = size(class3,1) / numPoints;
nTrain = ceil(numPoints*trainRatio);
nTest = ceil(numPoints*(1-trainRatio));
nTrain1 = ceil(nTrain*class1Ratio);
nTrain2 = ceil(nTrain*class2Ratio);
nTrain3 = ceil(nTrain*class3Ratio);
nTest1 = ceil(nTest*class1Ratio);
nTest2 = ceil(nTest*class2Ratio);
nTest3 = ceil(nTest*class3Ratio);
train1 = class1(1:nTrain1,:,:);
train2 = class2(1:nTrain2,:,:);
train3 = class3(1:nTrain3,:,:);
train1 = lowpassFilter(train1);
train2 = lowpassFilter(train2);
train3 = lowpassFilter(train3);
feat1 = silhouetteFeature(train1);
feat2 = silhouetteFeature(train2);
feat3 = silhouetteFeature(train3);
cov1 = seqCovariance(feat1);
cov2 = seqCovariance(feat2); % [n,3,3]
cov3 = seqCovariance(feat3);
%% Build Multi-class KNN model
train = cell(3,1);
train{1} = cov1;
train{2} = cov2;
train{3} = cov3;
model = knnMultiClass(k,3,train);
%% prepare test data
test1 = class1(nTrain1:nTrain1+nTest1,:,:);
test2 = class2(nTrain2:nTrain2+nTest2,:,:);
test3 = class3(nTrain3:nTrain3+nTest3,:,:);
test1 = lowpassFilter(test1);
test2 = lowpassFilter(test2);
test3 = lowpassFilter(test3);
f_1 = silhouetteFeature(test1);
f_2 = silhouetteFeature(test2);
f_3 = silhouetteFeature(test3);
c_1 = seqCovariance(f_1);
c_2 = seqCovariance(f_2);
c_3 = seqCovariance(f_3);
%% Test model
test = cell(3,1);
test{1} = c_1;
test{2} = c_2;
test{3} = c_3;
disp("Confusion Matrix of test data");
disp(model.ConfusionMatrix(test));