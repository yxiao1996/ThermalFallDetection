function norm_img = normalizeImage(img)
%NORMALIZEIMAGE normalize matrix to [0,1] for imshow
    min_val = min(min(img));
    max_val = max(max(img));
    norm_img = (img - min_val) / (max_val - min_val);
end

