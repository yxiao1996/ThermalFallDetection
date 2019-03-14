function frames = SeqsToFrames(seqs)
%SEQSTOFRAMES put video clipps together
    numSeqs = size(seqs,1);
    seqLen = size(seqs,2);
    numRow = size(seqs,3);
    numCol = size(seqs,4);
    frames = zeros(numSeqs*seqLen,numRow,numCol);
    for i = 1:numSeqs
        for j = 1:seqLen
            f = squeeze(seqs(i,j,:,:));
            fIdx = (i-1)*seqLen + j;
            frames(fIdx,:,:) = f;
        end
    end
end

