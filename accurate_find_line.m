function [U,R,D,L,x0] = accurate_find_line(X,Y)
%The function accurate_find_line() divides all edge points of a rectangle to
%four goups of points which corresponding to fours lines of the rectangle.

%   input: 
%   X,Y: The position of points in the edge of the rectangle, colum vector
%   output: 
%        U,R,D,L: four groups of coordinates
%           U:coordinates of points which belongs to the line on the up
%           R:coordinates of points which belongs to the line on the right               
%           D:coordinates of points which belongs to the line on the bottom           
%           L:coordinates of points which belongs to the line on the left
%           x0:[mx,my,L0,W0,theta0] is the estimated rectangle parameters
%              mx,my:estimated coordinates of the center point of the
%              rectangle; L0,W0,estimated size;theta0:estimated inclination

% Version: 1.0 2018.07.20 by rkkuang

my = mean(Y);
mx = mean(X);

vecs = [X Y]-[mx,my];
Dis = sqrt(dot(vecs',vecs'));
[~,min_index] = min(Dis);
min2middle_point = [X(min_index),Y(min_index)];

%Rotate all points to make the long side of the rectangle to be
%horizontally seated.
if min2middle_point(2) > my  
    %The angle need to rotated to make the long side horizontally seated
    rotang = 90 - acosd(dot(min2middle_point-[mx,my],[1,0])/(norm(min2middle_point-[mx,my])*norm([1,0])));
    
    %xang is the amount of angle needs to add into the computed angle after rotation
    xang = -rotang;
else
    rotang = acosd(dot(min2middle_point-[mx,my],[1,0])/(norm(min2middle_point-[mx,my])*norm([1,0])));
    xang = 90 - rotang;
end

%Aang is the rotating matrix.
Aang = [cosd(rotang),-sind(rotang);sind(rotang),cosd(rotang)];

%Rotate all points to make the long side horizontally seated.
XY = Aang*[X';Y'];
xx = XY(1,:);
yy = XY(2,:);

%Computing the center and four corner points from a set of coordinates
[point,point_index] = comp_corner(xx,yy);

%Computing the estimated initial length and width from the coordinates of four corner points
[ L0,W0,~ ] = point2init( point );

%Computing four groups of index corresponding to four lines of the rectangle 
[left_index,right_index,up_index,down_index] = findline_index(xx,yy,L0,W0);

point_real = [[X(point_index(1)),Y(point_index(1))];[X(point_index(2)),Y(point_index(2))];...
    [X(point_index(3)),Y(point_index(3))];[X(point_index(4)),Y(point_index(4))]];

realpoint = judgepoint(point_real(:,1),point_real(:,2));
[ L0,W0,theta0 ] = point2init( [0,0;realpoint]);

%Determine the actual coordinates of points in four lines of the rectangle
L = [X(left_index) Y(left_index)];
R = [X(right_index) Y(right_index)];
U = [X(up_index) Y(up_index)];
D = [X(down_index) Y(down_index)];
x0 = [mx,my,L0,W0,theta0];

end