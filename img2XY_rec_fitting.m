function [X,Y ,x0] = img2XY_rec_fitting(pic_name)
%The function img2XY_rec_fitting() is used to compute the coordinates of
%the edge points of the rectangle from a image
%   input: 
%       pic_name: the image name of a image to be analyzed, eg: './img1.jpg'
%   output: 
%        [X,Y ,x0]: 
%        X,Y:The coordinates of the edge points of the rectangle and
%            the estimated rectangle parameters of the rectangle
%        x0:[mx,my,L0,W0,theta0] is the estimated rectangle parameters
%              mx,my:estimated coordinates of the center point of the
%              rectangle; L0,W0,estimated size;theta0:estimated inclination

% Version: 1.0 2018.08.20 by rkkuang


im_captured = rgb2gray(im2double(imread(strcat(pic_name))));

% figure();
% set(gcf,'color','w');
% imshow(im2double(imread(strcat(pic_name))));
% title('The image of a micro work piece','fontsize',18);
% axis on;
% set(gca,'FontSize',18);

[R,C,~] = size(im_captured);
mask = zeros(R,C);
Rcoe = 10;
Ccoe = 8;

subimg = im_captured(round(R/Rcoe):R-round(R/Rcoe),round(C/Ccoe):C-round(C/Ccoe));
subimg = imbinarize(subimg,0.01);
thresh=[0.1,0.2];  
sigma=3;
subimg = edge(subimg,'Canny',thresh,sigma);

mask(round(R/Rcoe):R-round(R/Rcoe),round(C/Ccoe):C-round(C/Ccoe)) = subimg;

[y,x] = find(mask==1);
[U,R,D,L,x0] = accurate_find_line(x,y);

X = [U(:,1);R(:,1);D(:,1);L(:,1)];%colum vector
Y = [U(:,2);R(:,2);D(:,2);L(:,2)];
end