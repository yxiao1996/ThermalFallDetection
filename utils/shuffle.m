function shuffled = shuffle(frames)
%SHUFFLE 
% shuffle the original frames random order
    shuffled = zeros(size(frames));
    numFrames = size(frames,1);
    for i = 1:numFrames % copy
        shuffled(i,:,:) = frames(i,:,:);
    end
    for i = 1:numFrames
        for j = 1:numFrames
            if (rand>0.5)
                tmpi = shuffled(i,:,:);
                shuffled(i,:,:) = shuffled(j,:,:);
                shuffled(j,:,:) = tmpi;
            end
        end
    end
end

