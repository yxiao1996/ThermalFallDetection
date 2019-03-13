clear all
close all

walk_1 = load("data_walk0.mat");
squat_1 = load("data_squat0.mat");
walk_2 = load("data_walk1.mat");
squat_2 = load("data_squat1.mat");
nTrain = 200;
nTest = 100;
%% prepare training data
data_1 = mergeSequence(walk_1.data,walk_2.data);
data_2 = mergeSequence(squat_1.data,squat_2.data);
class1 = shuffle(data_1);
class2 = shuffle(data_2);

train1 = class1(1:nTrain,:,:);
train2 = class2(1:nTrain,:,:);
train1 = lowpassFilter(train1);
train2 = lowpassFilter(train2);
feat1 = naiveFeature(train1);
feat2 = naiveFeature(train2);
cov1 = seqCovariance(feat1);
cov2 = seqCovariance(feat2);

%% prepare test data
t_1 = class1(nTrain:nTrain+nTest,:,:);
t_2 = class2(nTrain:nTrain+nTest,:,:);
t_1 = lowpassFilter(t_1);
t_2 = lowpassFilter(t_2);
f_1 = naiveFeature(t_1);
f_2 = naiveFeature(t_2);
c_1 = seqCovariance(f_1);
c_2 = seqCovariance(f_2);

%% run svm
svm(cov1,cov2,c_1,c_2);