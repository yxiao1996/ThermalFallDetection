clear all
close all

img = double(imread("barbara.tif"))/255;
bimg_orig = double(img>0.5);
bimg = bimg_orig;
% add some random noisy
for i = 1:size(bimg,1)
    for j = 1:size(bimg,2)
        if rand < 0.05
            bimg(i,j) = 1-bimg(i,j);
        end
    end
end
disp(sum(sum(abs(bimg-bimg_orig))));
figure(1);
imshow(bimg);
M = Markov1stOrder(0.1,1,1);
M = M.setImage(bimg);
d = M.ICM_scan(1);
disp(sum(sum(abs(bimg_orig-d))));
figure(2);
imshow(d);