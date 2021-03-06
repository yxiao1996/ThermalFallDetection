%% view dataset in sequence
data = load("topFall.mat");
seqs = data.fall;
frames = SeqsToFrames(seqs);
frames = subtractMedian(frames);
numF = size(frames,1);
for i = 1:numF
    sample = frames(i,:,:);
    sample = lowpassFilter(sample);
    %sample = clusterSequence(sample);
    %sample = subtractMedian(sample);
    %sample = computeSilhouette(sample,0);
    %sample = Markov1stDenoise(sample,5000);
    playFrames(sample,1);
end