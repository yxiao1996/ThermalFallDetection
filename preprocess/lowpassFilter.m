function filtFrames = lowpassFilter(frames)
    numFrame = size(frames,1);
    filtFrames = zeros(size(frames));
    for i = 1:numFrame
        frame = squeeze(frames(i,:,:));
        %flt = DCT(frame);
        %flt = FIR(frame);
        flt = medfilt2(frame,[3 3],'symmetric');  %output pixel contains the median value in the 3-by-3 neighborhood
        filtFrames(i,:,:) = flt;
    end
end

function filtered=DCT(original)
    [m,n]=size(original); 
    Y=dct2(original); 
    I=zeros(m,n);
    I(1:round(0.5*m),1:round(0.5*n))=1; 
    Ydct=Y.*I;
    Y=idct2(Ydct); 
    filtered = Y;
end

function filtered=FIR(original)
ws=0.6;
wp=0.5;
coefficient=46;
f = [0 wp ws 1];
a = [1 1 0 0];
b = firpm(coefficient,f,a);
[y1,t1] = impz(b);
[y2,t2] = impz(b);
y=y1*y2';
%filtered = imfilter(original,y) ;
filtered = imgaussfilt(original);
end