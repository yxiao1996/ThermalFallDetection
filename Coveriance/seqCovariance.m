function  covariances = seqCovariance(features)
%SEQCOVERIANCE 
% compute the coveriance matrix given a vector field
    numFrame = size(features,1);
    numRow = size(features,2);
    numCol = size(features,3);
    numFeat = size(features,4);
    covariances = zeros(numFrame,numFeat,numFeat);
    for i = 1:numFrame
        feature = squeeze(features(i,:,:,:));
        % compute mean for each feture
        mu = zeros(numFeat,1);
        for r = 1:numRow
            for c = 1:numCol
                for f = 1:numFeat
                    mu(f) = mu(f) + feature(r,c,f);
                end
            end
        end
        mu = mu / (numRow*numCol);
        % compute the covariance matrix for this frame
        covariance = zeros(numFeat,numFeat);
        for r = 1:numRow
            for c = 1:numCol
                for f1 = 1:numFeat
                    for f2 = 1:numFeat
                        mu1 = mu(f1); mu2 = mu(f2);
                        U1 = feature(r,c,f1); U2 = feature(r,c,f2);
                        covariance(f1,f2) = covariance(f1,f2) + (U1-mu1)*(U2-mu2);
                    end
                end
            end
        end
        covariance = covariance / (numRow*numCol);
        covariances(i,:,:) = covariance;
    end
end

