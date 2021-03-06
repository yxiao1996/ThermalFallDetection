function playFrames(frames,figureId)
    numFrames = size(frames,1);
    figure(figureId);
    for i = 1:numFrames
        img = squeeze(frames(i,:,:));
        max_val = max(max(img));
        min_val = min(min(img));
        img_norm = (img - min_val) / (max_val - min_val);
        %img_norm = lowpass(img_norm);
        img = imresize(img_norm,10);
        imshow(img);
        %pause(0.005);
    end
end