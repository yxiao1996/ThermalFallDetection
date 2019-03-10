function silFrames = computeSilhouette(frames,thresh)
    %COMPUTESILHOUETTE Compute the silhouette image using a threshold
    silFrames = zeros(size(frames));
    numFrames = size(frames,1);
    numRow = size(frames,2);
    numCol = size(frames,3);
    for i = 1:numFrames
        silFrame = zeros(numRow,numCol);
        for j = 1:numRow
            for k = 1:numCol
                if (frames(i,j,k) < thresh)
                    silFrame(j,k) = 1;
                else
                    silFrame(j,k) = 0;
                end
            end
        end
        silFrames(i,:,:) = silFrame;
    end
end

