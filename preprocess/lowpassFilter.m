function filtFrames = lowpassFilter(frames)
    numFrame = size(frames,1);
    filtFrames = zeros(size(frames));
    for i = 1:numFrame
        frame = squeeze(frames(i,:,:));
        flt = lowpass(frame);
        filtFrames(i,:,:) = flt;
    end
end

function filtered=lowpass(original)
    [m,n]=size(original); 
    Y=dct2(original); 
    I=zeros(m,n);
    I(1:round(0.5*m),1:round(0.5*n))=1; 
    Ydct=Y.*I;
    Y=idct2(Ydct); 
    filtered = Y;
end
