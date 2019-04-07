function filtFrames = lowpassFilter(frames)
    numFrame = size(frames,1);
    filtFrames = zeros(size(frames));
    for i = 1:numFrame
        frame = squeeze(frames(i,:,:));
        flt = medfilt2(frame,[3 3]);  %output pixel contains the median value in the 3-by-3 neighborhood
        filtFrames(i,:,:) = flt;
    end
end
