clear all
close all

walk = load("walk.mat");
squat = load("squat.mat");
trainRatio = 0.8;
k = 5;
%% prepare training data
class1 = SeqsToFrames(walk.walk);
class2 = SeqsToFrames(squat.squat);
class1 = shuffle(class1);
class2 = shuffle(class2);

numPoints = size(class1,1)+size(class2,1);
class1Ratio = size(class1,1) / numPoints;
class2Ratio = size(class2,1) / numPoints;
nTrain = ceil(numPoints*trainRatio);
nTest = ceil(numPoints*(1-trainRatio));
nTrain1 = ceil(nTrain*class1Ratio);
nTrain2 = ceil(nTrain*class2Ratio);
nTest1 = ceil(nTest*class1Ratio);
nTest2 = ceil(nTest*class2Ratio);
train1 = class1(1:nTrain1,:,:);
train2 = class2(1:nTrain2,:,:);
train1 = lowpassFilter(train1);
train2 = lowpassFilter(train2);
feat1 = naiveFeature(train1);
feat2 = naiveFeature(train2);
cov1 = seqCovariance(feat1);
cov2 = seqCovariance(feat2); % [n,3,3]
model = knn(cov1,cov2,k);
%% prepare test data
t_1 = class1(nTrain1:nTrain1+nTest1,:,:);
t_2 = class2(nTrain2:nTrain2+nTest2,:,:);
t_1 = lowpassFilter(t_1);
t_2 = lowpassFilter(t_2);
f_1 = naiveFeature(t_1);
f_2 = naiveFeature(t_2);
c_1 = seqCovariance(f_1);
c_2 = seqCovariance(f_2);

disp("test class 1 accuracy");
disp(model.test(c_1,1));
figure(1);
model.vizDistance(c_1);

disp("test class 2 accuracy");
figure(2)
model.vizDistance(c_2);
disp(model.test(c_2,2));