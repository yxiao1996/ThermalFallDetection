function features = silhouetteFeature(frames)
%SILHOUETTEFEATURE compute silhouette feature of a sequence of frames
    thresh = 0.5;
    frames = clusterSequence(frames);
    frames = computeSilhouette(frames,0);
    numFrame = size(frames,1);
    numRow = size(frames,2);
    numCol = size(frames,3);
    features = zeros(numFrame,numRow,numCol,6);
    for i = 1:numFrame
        f = squeeze(frames(i,:,:));
        for y = 1:numRow
            for x = 1:numCol
                dN = compute_dN(y,x,f,thresh);
                dS = compute_dS(y,x,f,thresh);
                dE = compute_dE(y,x,f,thresh);
                dW = compute_dW(y,x,f,thresh);
                features(i,y,x,:) = [x y dN dE dW dS];
            end
        end
    end
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
    % compute dN given x,y and the frame
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
    % compute dN given x,y and the frame
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
    % compute dN given x,y and the frame
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

