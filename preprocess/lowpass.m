function filtered=lowpass(original)
    [m,n]=size(original); 
    Y=dct2(original); 
    I=zeros(m,n);
    I(1:round(0.4*m),1:round(0.4*n))=1; 
    Ydct=Y.*I;
    Y=idct2(Ydct); 
    filtered = Y;
end
