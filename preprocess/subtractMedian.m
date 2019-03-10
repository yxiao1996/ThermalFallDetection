function sub_frames = subtractMedian(frames)
    sub_frames = zeros(size(frames));
    mid_img = medianImage(frames);
    numFrames = size(frames,1);
    for i = 1:numFrames
        img = squeeze(frames(i,:,:)) - mid_img;
        sub_frames(i,:,:) =  img;
    end
end
%% helper functions
function mid_img = medianImage(frames)
    numFrames = size(frames,1);
    mid_img = zeros(size(frames,2),size(frames,3));
    for i = 1:numFrames
        img = squeeze(frames(i,:,:));
        mid_img = mid_img + img;
    end
    mid_img = mid_img / numFrames;
end