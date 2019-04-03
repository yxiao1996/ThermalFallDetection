clear all
close all
data = load("walk.mat");
seqs = data.walk;
numSeq = size(seqs,1);
seqIdx = ceil(rand*numSeq);
seq = squeeze(seqs(seqIdx,:,:,:));
fIdx = [1 5 10];
for i = 1:length(fIdx)
    f = squeeze(seq(i,:,:));
    show(f,i);
end

function show(frame,fId)
    max_val = max(max(frame));
    min_val = min(min(frame));
    frame = (frame-min_val)/(max_val-min_val);
    img = imresize(frame,10);
    figure(fId);
    imshow(img);
    colormap default
end