function cov = silhouetteTunnelCovariance(frames)
%SILHOUETTETUNNELFEATURE 
    % compute the covariance matrix given a sequence of frames
    thresh = 0.5;
    frames = lowpassFilter(frames);
    frames = clusterSequence(frames);
    frames = computeSilhouette(frames,0);
    numFrame = size(frames,1);
    numRow = size(frames,2);
    numCol = size(frames,3);
    features = zeros(numFrame,numRow,numCol,13);

    for i = 1:numFrame
        f = squeeze(frames(i,:,:));
        for y = 1:numRow
            for x = 1:numCol
                %disp("*");
                dN = compute_dN(y,x,f,thresh);
                dS = compute_dS(y,x,f,thresh);
                dE = compute_dE(y,x,f,thresh);
                dW = compute_dW(y,x,f,thresh);
                dNE = compute_dD(y,x,f,thresh,true,true);
                dSE = compute_dD(y,x,f,thresh,false,true);
                dSW = compute_dD(y,x,f,thresh,false,false);
                dNW = compute_dD(y,x,f,thresh,true,false);
                dTm = compute_dT(y,x,i,frames,thresh,true);
                dTp = compute_dT(y,x,i,frames,thresh,false);
                features(i,y,x,:) = [x y i dN dE dW dS dNE dSE dSW dNW dTm dTp];
            end
        end
    end
    cov = tunnelCovariance(features);
end

function dN = compute_dN(y,x,f,thresh)
    % compute dN given x,y and the frame
    dN = 0;
    x_ = x; y_ = y;
    while(f(y_,x_)>thresh)
        dN = dN + 1;
        if (y_==1)
            break;
        else
            y_ = y_ - 1;
        end
    end
end

function dS = compute_dS(y,x,f,thresh)
    % compute dS given x,y and the frame
    dS = 0;
    x_ = x; y_ = y;
    while(f(y_,x_)>thresh)
        dS = dS + 1;
        if (y_==size(f,1))
            break;
        else
            y_ = y_ + 1;
        end
    end
end

function dE = compute_dE(y,x,f,thresh)
    % compute dE given x,y and the frame
    dE = 0;
    x_ = x; y_ = y;
    while(f(y_,x_)>thresh)
        dE = dE + 1;
        if (x_==size(f,2))
            break;
        else
            x_ = x_ + 1;
        end
    end
end

function dW = compute_dW(y,x,f,thresh)
    % compute dW given x,y and the frame
    dW = 0;
    x_ = x; y_ = y;
    %disp(x_);
    while(f(y_,x_)>thresh)
        dW = dW + 1;
        if(x_==1)
            break;
        else
            x_ = x_ - 1;
        end
    end
end

function dD = compute_dD(y,x,f,thresh,N,E)
    dD = 0;
    if(N)
        dy = -1;
    else
        dy = 1;
    end
    if(E)
        dx = 1;
    else
        dx = -1;
    end
    x_ = x; y_ = y;
    [m,n] = size(f);
    while(f(y_,x_)>thresh)
        dD = dD + 1;
        x_ = x_ + dx;
        y_ = y_ + dy;
        if(x_ <= 1 || y_ <= 1)
            break;
        end
        if(x_ >= n || y_ >= m)
            break;
        end
    end
end

function dT = compute_dT(y,x,i,frames,thresh,Minus)
    % compute dT element in silhouette tunnel covariance
    dT = 0;
    if(Minus)
        dt = -1;
    else
        dt = 1;
    end
    i_ = i;
    m = size(frames,1);
    while(frames(i_,y,x)>thresh)
        dT = dT + 1;
        i_ = i_ + dt;
        if(i_ <= 1 || i_ >= m)
            break;
        end
    end
end

function  covariance = tunnelCovariance(features)
%tunnelCOVERIANCE 
% compute the coveriance matrix given a silhouette tunnel feature
    numFrame = size(features,1);
    numRow = size(features,2);
    numCol = size(features,3);
    numFeat = size(features,4);
    mu = zeros(numFeat,1);
    for i = 1:numFrame
        feature = squeeze(features(i,:,:,:));
        % compute mean for each feture
        for r = 1:numRow
            for c = 1:numCol
                for f = 1:numFeat
                    mu(f) = mu(f) + feature(r,c,f);
                end
            end
        end
    end
    mu = mu / (numRow*numCol*numFrame);
    % compute the covariance matrix for this frame
    covariance = zeros(numFeat,numFeat);
    for i = 1:numFrame
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
    end
    covariance = covariance / (numRow*numCol*numFrame);
end

