%% view dataset in sequence
data = load("fall.mat");
seqs = data.fall;
numSeq = size(seqs,1);
for i = 1:numSeq
    sample = squeeze(seqs(i,:,:,:));
    sample = lowpassFilter(sample);
    sample = clusterSequence(sample,26);
    %sample = subtractMedian(sample);
    %sample = computeSilhouette(sample,26);
    %sample = Markov1stDenoise(sample,5000);
    playFrames(sample,1);
end