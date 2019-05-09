function [ L0,W0,theta0 ] = point2init( point )
%The point2init() function computes the length, width, and inclination of a
%rectangle from its coordinates of corners 
%   input: 
%        point:The coordinates of corners of a rectangle
%   output:
%        L0,W0:The estimated size of the original rectangle
%        theta0: The estimated inclination of the rectangle

% Version: 1.0 2018.07.20 by rkkuang

%initialize
leftdownpoint=[point(2,1),point(2,2)];
rightdownpoint=[point(3,1),point(3,2)];
leftuppoint=[point(4,1),point(4,2)];
rightuppoint=[point(5,1),point(5,2)];

%Computing the length
a = rightuppoint - leftuppoint;
b = rightdownpoint - leftdownpoint;
l1 = norm(a);
l2 = norm(b);
L0 = (l1+l2)/2;

%Computing the width
w1 = norm(leftuppoint-leftdownpoint);
w2 = norm(rightdownpoint-rightuppoint);
W0 = (w1+w2)/2;
%Computing the inclination
theta1 = acosd(dot(a,[1,0])/(norm(a)*norm([1,0])));
theta2 = acosd(dot(b,[1,0])/(norm(b)*norm([1,0])));
theta0 = (theta1+theta2)/2;

if rightuppoint(2) < leftuppoint(2)
    %The inclination have a negative value
    theta0 = -theta0;
end
end