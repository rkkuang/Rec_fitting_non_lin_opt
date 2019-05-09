function [k,b] = linear_regression(x,y,~)
%The linear_regression() function is used to do the linear regression based
%on the coordinates of a group of points.

%input: x,y: the coordinates vectors of a group of points
%output: k,b: The weight and the bias

% Version1: 20180124 by rkkuang

A = [x',ones(length(x),1)];
ab = A\y';
k = ab(1);
b = ab(2);
end