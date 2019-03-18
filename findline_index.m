function [left_index,right_index,up_index,down_index] = findline_index(xx,yy,L0,W0)
%The function findline_index() divides all edge points of a rectangle to
%four goups of points which corresponding to fours lines of the rectangle,
%and return the index of those points.

%   input: 
%   xx,yy: The position of points in the edge of the rectangle after rotated, colum vector
%   L0,W0:The estimated size of the original rectangle
%   output: 
%        left_index,right_index,up_index,down_index: four vectors of the
%        index of the points corresponding to lines of the rectangle.
%           up_index:index of points which belongs to the line on the up
%           right_index:index of points which belongs to the line on the right               
%           down_index:index of points which belongs to the line on the bottom           
%           left_index:index of points which belongs to the line on the left

% Version: 1.0 2018.07.20 by rkkuang
%Version:2.0 2018.09.03 remove all for loops and use the find() function 

thre = 0;%or 2
tuningcoe = 0;%or 1/30
%Smaller this parameter, less points will be dropped away

%2018.07.22
%Adding a parameter for tunning's seak, to make sure the classification of
%four groups of points more accurate, and thus make the automatically 
% estimated initial value of the rectangle more accurate.

tuningL = -round(L0*tuningcoe);
tuningW = -round(W0*tuningcoe);

point = comp_corner(xx,yy);

leftdownpoint = point(2,:);
rightdownpoint= point(3,:);
leftuppoint= point(4,:);
rightuppoint= point(5,:);

%Find points on the left line of the rectangle
left_index = find((xx<=max(leftdownpoint(1),leftuppoint(1))+thre) & ...
    (yy>=leftdownpoint(2)-tuningW) & (yy<=leftuppoint(2)+tuningW));

right_index = find((xx>=min(rightdownpoint(1),rightuppoint(1))-thre) & ...
    (yy<=rightuppoint(2)+tuningW) & (yy>=rightdownpoint(2)-tuningW));

down_index = find((yy<=max(leftdownpoint(2),rightdownpoint(2))+thre) & ...
    (xx>=leftdownpoint(1)-tuningL) & (xx<=rightdownpoint(1)+tuningL));

up_index = find((yy>=min(leftuppoint(2),rightuppoint(2))-thre) & ...
(xx>=leftuppoint(1)-tuningL) & (xx<=rightuppoint(1)+tuningL));
end