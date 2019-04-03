%% generate example image for report
clear all
close all
data = load("squat.mat");
seqs = data.squat;
numSeq = size(seqs,1);
seqIdx = ceil(rand*numSeq);
seq = squeeze(seqs(seqIdx,:,:,:));
fIdx = ceil(rand*size(seq,1));
f = seq(fIdx,:,:);
showFrame(squeeze(f),1);
f = lowpassFilter(f);
showFrame(squeeze(f),2);
f = clusterSequence(f);
showFrame(squeeze(f),3);
%sample = subtractMedian(sample);
f = computeSilhouette(f,0);
showFrame(squeeze(f),4);
f = Markov1stDenoise(f,5000);
showFrame(squeeze(f),5);