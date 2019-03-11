clear all
close all

data_1 = load("data_stand.mat");
data_2 = load("data_sit.mat");
n = 100;
k = 5;
%% prepare training data
class1 = data_1.data(1:n,:,:);
class2 = data_2.data(1:n,:,:);
class1 = lowpassFilter(class1);
class2 = lowpassFilter(class2);
feat1 = naiveFeature(class1);
feat2 = naiveFeature(class2);
cov1 = seqCovariance(feat1);
cov2 = seqCovariance(feat2);
model = knn(cov1,cov2,k);
%% prepare test data
t_1 = data_1.data(n:n+50,:,:);
t_2 = data_2.data(n:n+50,:,:);
t_1 = lowpassFilter(t_1);
t_2 = lowpassFilter(t_2);
f_1 = naiveFeature(t_1);
f_2 = naiveFeature(t_2);
c_1 = seqCovariance(f_1);
c_2 = seqCovariance(f_2);

disp("test class 1 accuracy");
disp(model.test(c_1,1));
disp("test class 2 accuracy");
disp(model.test(c_2,2));