%% view dataset in sequence
data = load("sit.mat");
seqs = data.sit;
numSeq = size(seqs,1);
for i = 1:numSeq
    sample = squeeze(seqs(i,:,:,:));
    sample = lowpassFilter(sample);
    sample = clusterSequence(sample);
    %sample = subtractMedian(sample);
    sample = computeSilhouette(sample,0);
    sample_d = Markov1stDenoise(sample,5000);
    %playFrames(sample,1);
    playFrames(sample_d,2);
end