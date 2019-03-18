function realpoint = judgepoint(x,y)
%The judgepoint() function is used to determine which points are 
% on the left-down, left-up, right-down, right-up position

%input: x,y: the coordinates vectors of a group of points
%output: realpoint: The coordinates of the left-down, left-up, right-down,
%right-up points.

% Version1: 20181016 by rkkuang

x=x';
y=y';
[~,minx_index1] = min(x);
minx2 = min(x(x>x(minx_index1)));
[~,minx_index2] = find(x == minx2);

ld_index = (y(minx_index2) > y(minx_index1))*minx_index2 + (y(minx_index2) < y(minx_index1))*minx_index1;
lu_index = (y(minx_index2) > y(minx_index1))*minx_index1 + (y(minx_index2) < y(minx_index1))*minx_index2;

%max_index contains the two right points
[~,max_index] = find(x>(max(x(minx_index1),x(minx_index2)))); 
rd_index = (y(max_index(1)) > y(max_index(2)))*max_index(1) + (y(max_index(1)) < y(max_index(2)))*max_index(2);
ru_index = (y(max_index(1)) > y(max_index(2)))*max_index(2) + (y(max_index(1)) < y(max_index(2)))*max_index(1);

realpoint = [
    x(ld_index),y(ld_index);...
    x(rd_index),y(rd_index);...
    x(lu_index),y(lu_index);...
    x(ru_index),y(ru_index)];
end