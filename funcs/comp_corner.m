function [point,point_index] = comp_corner(xx,yy)
%The comp_corner() function computes the position of four corners from all
%coordinates of edge points.

%   input: 
%   xx,yy: The position of points in the edge of the rectangle after rotated, colum vector
%   output: 
%        point = [[mx,my];leftdownpoint;rightdownpoint;leftuppoint;rightuppoint];
%        leftdownpoint,rightdownpoint,leftuppoint,rightuppoint,Mxy ,point_index
%        are the positions of four corner points and Mxy is the center
%        position of the rectangle. point_index is their index

%Version:1.0 2018.09.03 by rkkuang
%remove all for loops and use the find() function 

my = mean(yy);
mx = mean(xx);

%Computing distances of all edge points to the center point
%vecs = [xx' yy']-[mx,my];
vecs = [xx'-mx, yy'-my];%190416
Dis = sqrt(dot(vecs',vecs'));
leftdown = find(xx<mx & yy<my);%Index of all points in the leftdown position
[~,tempindex] = max(Dis(leftdown));
leftdownpoint_index = leftdown(tempindex);
leftdownpoint = [xx(leftdownpoint_index),yy(leftdownpoint_index)];

rightdown = find(xx>mx & yy<my);%Index of all points in the rightdown position
[~,tempindex] = max(Dis(rightdown));
rightdownpoint_index = rightdown(tempindex);
rightdownpoint = [xx(rightdownpoint_index),yy(rightdownpoint_index)];

leftup = find(xx<mx & yy>my);%Index of all points in the leftup position
[~,tempindex] = max(Dis(leftup));
leftuppoint_index = leftup(tempindex);
leftuppoint = [xx(leftuppoint_index),yy(leftuppoint_index)];

rightup = find(xx>mx & yy>my);%Index of all points in the rightup position
[~,tempindex] = max(Dis(rightup));
rightuppoint_index = rightup(tempindex);
rightuppoint = [xx(rightuppoint_index),yy(rightuppoint_index)];
point_index = [leftdownpoint_index;rightdownpoint_index;leftuppoint_index;rightuppoint_index];

point = [[mx,my];leftdownpoint;rightdownpoint;leftuppoint;rightuppoint];
end