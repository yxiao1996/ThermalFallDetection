function clusters = clusterSequence(seq,T)
    numFrames = size(seq,1);
    numRow = size(seq,2);
    numCol = size(seq,3);
    clusters = zeros(numFrames,numRow,numCol);
    for i = 1:numFrames
        f = squeeze(seq(i,:,:));
        clusters(i,:,:) = clusterFrame(f,T);
    end
end
function body = clusterFrame(f,T)
    f_single = im2single(f);
    numCol = 2;
    pxl_labels = imsegkmeans(f_single,numCol,'NumAttempts',7);
    masks = zeros(size(f,1),size(f,2));
    masks(find(f>T))=1;
    mask_i = (pxl_labels == 1);
    masks = masks.*double(mask_i);
    body=f.*masks;
end