function features = silhouetteFeature10(frames)
%SILHOUETTEFEATURE compute silhouette feature of a sequence of frames
    thresh = 0.5;
    frames = clusterSequence(frames);
    frames = computeSilhouette(frames,0);
    numFrame = size(frames,1);
    numRow = size(frames,2);
    numCol = size(frames,3);
    features = zeros(numFrame,numRow,numCol,10);
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
                features(i,y,x,:) = [x y dN dE dW dS dNE dSE dSW dNW];
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
    %dx = uint8(dx);
    %dy = uint8(dy);
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