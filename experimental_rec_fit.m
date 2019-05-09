%The experimental_rec_fit.m script is used to show the experimental results
%of the locating and size measuring of micro work pieces.

addpath(genpath('./funcs'));

count = 1;
realL = [];
realW = [];
pixelL = [];
pixelW = [];
imgL = 2592;
imgW = 1944;

bkgimgname = strcat('imgs/imgbak','.bmp');
bkgimg = rgb2gray(im2double(imread(strcat(bkgimgname))));
drop = 1;%drop some corner points
L0coe = 2;% Control the estimation of sigma0 = sqrt(2*L0)/L0coe;
for i=1:2
        imgname = strcat('imgs/size3_mid/img',num2str(i),'.bmp');
        im_captured = rgb2gray(im2double(imread(strcat(imgname))));
        
        subbkgimg = abs(im_captured - bkgimg);
        subbkgimg = subbkgimg./max(subbkgimg(:));
        subbkgimg = imbinarize(subbkgimg,0.5);
        [X,Y ,x0] = img2XY_rec_fitting(subbkgimg,drop);
        
        para1 = Rec_fitting(X,Y,x0,1,imgL,imgW,L0coe);
        pixelL(count) = para1(3);
        pixelW(count) = para1(4);
        count = count+1;
end