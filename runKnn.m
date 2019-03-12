clear all
close all

data_1 = load("data_walk1.mat");
data_2 = load("data_squat1.mat");
nTrain = 100;
nTest = 50;
k = 7;
%% prepare training data
class1 = shuffle(data_1.data);
class2 = shuffle(data_2.data);
%class1 = data_1.data;
%class2 = data_2.data;

train1 = class1(1:nTrain,:,:);
train2 = class2(1:nTrain,:,:);
train1 = lowpassFilter(train1);
train2 = lowpassFilter(train2);
feat1 = naiveFeature(train1);
feat2 = naiveFeature(train2);
cov1 = seqCovariance(feat1);
cov2 = seqCovariance(feat2); % [n,3,3]
model = knn(cov1,cov2,k);
%% prepare test data
t_1 = class1(nTrain:nTrain+nTest,:,:);
t_2 = class2(nTrain:nTrain+nTest,:,:);
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