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
    numCol = 3;
    pxl_labels = imsegkmeans(f_single,numCol,'NumAttempts',7);
    masks = zeros(numCol,size(f,1),size(f,2));
    mean_temp = zeros(numCol);
    for i = 1:numCol
        mask_i = (pxl_labels == i);
        masks(i,:,:) = double(mask_i);
        mean_temp(i) = mean_temperature(mask_i,f);
    end
    max_idx = find(mean_temp==max(mean_temp));
    T_mask = zeros(size(f,1),size(f,2));
    T_mask(find(f>T))=1;
    body = f .* squeeze(masks(max_idx(1),:,:)).*T_mask;
end

function mt = mean_temperature(mask,f)
    % compute mean temperature inside a mask
    mask = double(mask);
    mt = sum(sum(mask.*f)) / sum(sum(mask));
end