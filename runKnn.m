clear all
close all

data_1 = load("data_stand.mat");
data_2 = load("data_sit.mat");
n = 10;
k = 7;
class1 = data_1.data(1:n,:,:);
class2 = data_2.data(1:n,:,:);
class1 = lowpassFilter(class1);
class2 = lowpassFilter(class2);
feat1 = naiveFeature(class1);
feat2 = naiveFeature(class2);
cov1 = seqCovariance(feat1);
cov2 = seqCovariance(feat2);
model = knn(cov1,cov2,k);

t_1 = data_1.data(n:n+10,:,:);
t_2 = data_2.data(n:n+10,:,:);
t_1 = lowpassFilter(t_1);
t_2 = lowpassFilter(t_2);
f_1 = naiveFeature(t_1);
f_2 = naiveFeature(t_2);
c_1 = seqCovariance(f_1);
c_2 = seqCovariance(f_2);
for i = 1:10
    c = squeeze(c_1(i,:,:));
    consensus = model.classify(c);
    disp(consensus');
end
for i = 1:10
    c = squeeze(c_2(i,:,:));
    consensus = model.classify(c);
    disp(consensus');
end