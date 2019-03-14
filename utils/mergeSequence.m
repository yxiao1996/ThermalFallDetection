function merged = mergeSequence(seq1,seq2)
%MERGESEQUENCE 
%   merge to sequences
    lenSeq1 = size(seq1,1);
    lenSeq2 = size(seq2,1);
    lenMgd = lenSeq1+lenSeq2;
    numRow = size(seq1,2);
    numCol = size(seq1,3);
    merged = zeros(lenMgd,numRow,numCol);
    
    for i = 1:lenSeq1
        merged(i,:,:) = seq1(i,:,:);
    end
    for i = 1:lenSeq2
        merged(i+lenSeq1,:,:) = seq2(i,:,:);
    end
end

