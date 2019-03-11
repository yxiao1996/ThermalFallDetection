function features = naiveFeature(frames)
%NAIVEFEATURE compute a naive feature vector [x,y,temprature]
    numFrame = size(frames,1);
    numRow = size(frames,2);
    numCol = size(frames,3);
    features = zeros(numFrame,numRow,numCol,3); % [x,t,temp]
    for i = 1:numFrame
        frame = squeeze(frames(i,:,:));
        for y = 1:numRow
            for x = 1:numCol
                temp = frame(y,x);
                features(i,y,x,:) = [x y temp];
            end
        end
    end
end

