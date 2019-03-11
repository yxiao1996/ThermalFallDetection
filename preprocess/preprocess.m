clear all
close all
%% preprocess the raw thermal sensor readings
data_stand = load("./data/data_stand.mat");
data_sit = load("./data/data_sit.mat");

h = [
  1 1 1;
  1 1 1;
  1 1 1;
]/9;

seqs_stand = chopSequence(data_stand.data,10);
numSeq = size(seqs_stand,1);
for i = 1:numSeq
    sample = squeeze(seqs_stand(i,:,:,:));
    sample = subtractMedian(sample);
    %sample = computeSilhouette(sample,0.5);
    playFrames(sample,1);
end