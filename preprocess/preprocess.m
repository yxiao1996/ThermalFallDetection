clear all
close all
%% preprocess the raw thermal sensor readings
data_1 = load("data_hand.mat");
data_2 = load("topFall.mat");

h = [
  1 1 1;
  1 2 1;
  1 1 1;
]/9;

test_data = data_2.fall;
test_data = lowpassFilter(test_data);
seqs = chopSequence(test_data,10);
numSeq = size(seqs,1);
for i = 1:numSeq
    sample = squeeze(seqs(i,:,:,:));
    sample = clusterSequence(sample);
    %sample = subtractMedian(sample);
    sample = computeSilhouette(sample,0);
    sample_d = Markov1stDenoise(sample,5000);
    %playFrames(sample,1);
    playFrames(sample_d,2);
end