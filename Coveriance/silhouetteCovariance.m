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
        count = 1;
        for r = 1:numRow
            for c = 1:numCol
                feat = squeeze(feature(r,c,:));
                if (InSilhouette(feat))
                    count = count + 1;
                    for f = 1:numFeat
                        mu(f) = mu(f) + feature(r,c,f);
                    end
                end
            end
        end
        mu = mu / count; %(numRow*numCol);
        %disp(count);
        % compute the covariance matrix for this frame
        covariance = zeros(numFeat,numFeat);
        count = 1;
        for r = 1:numRow
            for c = 1:numCol
                feat = squeeze(feature(r,c,:));
                if(InSilhouette(feat))
                    count = count + 1;
                    for f1 = 1:numFeat
                        for f2 = 1:numFeat
                            mu1 = mu(f1); mu2 = mu(f2);
                            U1 = feature(r,c,f1); U2 = feature(r,c,f2);
                            covariance(f1,f2) = covariance(f1,f2) + (U1-mu1)*(U2-mu2);
                        end
                    end
                end
            end
        end
        covariance = covariance / count;%(numRow*numCol);
        covariances(i,:,:) = covariance;
    end
end

function in = InSilhouette(feat)
    N = feat(3); E = feat(4); W = feat(5); S = feat(6);
    if(N>0 || E>0 || W>0 || S>0)
        in = true;
    else
        in = false;
    end
end