function showFrame(frame,figureId)
    figure(figureId);
    norm = max(max(frame));
    img = imresize(frame/norm,10);
    imshow(img);
    colormap default
end