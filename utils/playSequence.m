function playSequence(seqs)
    numSeqs = size(seqs,1);
    for i = 1:numSeqs
        seq = squeeze(seqs(i,:,:,:));
        playFrames(seq,1);
    end
end