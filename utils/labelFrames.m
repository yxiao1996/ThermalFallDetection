function [class1,class2] = labelFrames(frames,l)
% chop the frames into smaller sequence the label them
    seqs = chopSequence(frames,l);
    numSeqs = size(seqs,1);
    labels = zeros(numSeqs,1);
    for i = 1:numSeqs
        seq = squeeze(seqs(i,:,:,:));
        labels(i) = labelSequence(seq);
    end
    % find all sequences of class 1
    c1Idx = find(labels==1);
    c2Idx = find(labels==2);
    numC1 = length(c1Idx);
    numC2 = length(c2Idx);
    class1 = zeros(numC1,l,size(frames,2),size(frames,3));
    class2 = zeros(numC2,l,size(frames,2),size(frames,3));
    for i = 1:numC1
        idx = c1Idx(i);
        class1(i,:,:,:) = seqs(idx,:,:,:);
    end
    for i = 1:numC2
        idx = c2Idx(i);
        class2(i,:,:,:) = seqs(idx,:,:,:);
    end
end

function label = labelSequence(seq)
%labelSequence play the sequence and wait for a label
    playFrames(seq,1);
    label = input("ener the class label: ");
end

