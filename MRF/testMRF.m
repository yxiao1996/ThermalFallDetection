clear all
close all

img = double(imread("barbara.tif"))/255;
bimg = double(img>0.5);
% add some random noisy
for i = 1:size(bimg,1)
    for j = 1:size(bimg,2)
        if rand < 0.05
            bimg(i,j) = 1-bimg(i,j);
        end
    end
end
figure(1);
imshow(bimg);
M = Markov1stOrder(0,10,0);
M = M.setImage(bimg);
d = M.ICM(10000);
figure(2);
imshow(d);