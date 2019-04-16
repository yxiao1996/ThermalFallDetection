load("svm_rbf.mat")
load("TrainTest0.mat"); % load data
TestFeature = data.TestFeature;
TestLabel = data.TestLabel;
classifier = OneVOnePredict(classifiers,3);
cm = classifier.ConfusionMatrix(TestFeature,TestLabel);
disp(cm);
acc = classifier.accuracy(TestFeature,TestLabel);
disp(acc);
