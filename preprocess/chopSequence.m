function sequences = chopSequence(frames,length)
%CHOPSEQUENCE 
%   chop the long video sequence into smaller 
%   sequences with certain length 
    numFrames = size(frames,1);
    numRow = size(frames,2);
    numCol = size(frames,3);
    numSeq = floor(numFrames/length);
    sequences = zeros(numSeq,length,numRow,numCol);
    for frameId = 1:numFrames
        inSeqId = mod(frameId,length);
        if(inSeqId == 0)
            inSeqId = length;
        end
        seqId = ceil(frameId/length);
        frame = squeeze(frames(frameId,:,:));
        sequences(seqId,inSeqId,:,:) = frame;
    end
end

