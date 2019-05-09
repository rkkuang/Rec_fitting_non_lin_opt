function [X,Y ,x0] = img2XY_rec_fitting(im_captured,drop)
%The function img2XY_rec_fitting() is used to compute the coordinates of
%the edge points of the rectangle from a image
%   input: 
%       pic_name: the image name of a image to be analyzed, eg: './img1.jpg'
%       drop: drop the corner points or not
%   output: 
%        [X,Y ,x0]: 
%        X,Y:The coordinates of the edge points of the rectangle and
%            the estimated rectangle parameters of the rectangle
%        x0:[mx,my,L0,W0,theta0] is the estimated rectangle parameters
%              mx,my:estimated coordinates of the center point of the
%              rectangle; L0,W0,estimated size;theta0:estimated inclination

% Version: 1.0 2018.08.20 by rkkuang

thresh=[0.1,0.2];  
sigma=3;
im_captured = dilaterode(im_captured,2,1,1,5);
mask = edge(im_captured,'Canny',thresh,sigma);
[y,x] = find(mask==1);

[U,R,D,L,x0] = accurate_find_line(x,y,drop);

X = [U(:,1);R(:,1);D(:,1);L(:,1)];%colum vector
Y = [U(:,2);R(:,2);D(:,2);L(:,2)];
end