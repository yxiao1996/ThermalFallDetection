%% multi-class svm using one-versus-one scheme
clear
load("TrainTest1.mat"); % load data
numTest = 50;
classifiers = cell(3,3);
TrainFeature = data.TrainFeature;
TrainLabel = data.TrainLabel;
for i = 0:1
    for j = i+1:2
        disp(i);
        oneIdx = find(TrainLabel == i);
        otherIdx = find(TrainLabel == j);
        oneFeat = TrainFeature(oneIdx,:,:);
        otherFeat = TrainFeature(otherIdx,:,:);
        oneLabel = ones(size(oneFeat,1),1);
        otherLabel = -ones(size(otherFeat,1),1);
        Feat = [oneFeat;otherFeat];
        Label = [oneLabel;otherLabel];
        svm = KernelSVM(3);
        svm = svm.train(Feat,Label);
        svm.accuracy(Feat(1:numTest,:),Label(1:numTest));
        classifiers{i+1,j+1} = svm;
    end
end