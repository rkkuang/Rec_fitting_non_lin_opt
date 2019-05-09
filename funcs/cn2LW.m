function LW = cn2LW(cn)
%The cn2LW() function computes the coefficents (Xc,Yc,L,W,alpha) of a
%rectangle from coefficients (c1,c2,c3,c4,n1,n2);
%   input: 
%        c1,c2,c3,c4,n1,n2:coefficients which determin a rectangle
%   output: 
%       A vector LW = [Xc,Yc,L,W,alpha];
%       Xc,Yc: The position of the center point of a rectangle
%       L,W: The size of the rectangle (in pixels)
%       alpha: The angle of the rectangle to the horizontal (in degrees)
% Version: 1.0 2018.08.20 by rkkuang

% c1,c2,c3,c4,n1,n2
c1 = cn(1);
c2 = cn(2);
c3 = cn(3);
c4 = cn(4);
n1 = cn(5);
n2 = cn(6);

%intersection points (corner points of the rectangle)
aaa = -[n1 n2; -n2 n1]\[c1; c3];
ccc = -[n1 n2; -n2 n1]\[c1; c4];
     
bbb = -[n1 n2; -n2 n1]\[c2; c3];  
ddd = -[n1 n2; -n2 n1]\[c2; c4];
 
Middle(1) = (aaa(1)+bbb(1)+ccc(1)+ddd(1))/4;
Middle(2) = (aaa(2)+bbb(2)+ccc(2)+ddd(2))/4;

x = [aaa(1),bbb(1),ccc(1),ddd(1)];
y = [aaa(2),bbb(2),ccc(2),ddd(2)];

%Determine which point is on leftup leftdown rightup rightdown index
%minx_index1 minx_index2 corresponding to the 2 left points
[~,minx_index1] = min(x);%The minimal coordinate of 4 x coordinate
minx2 = min(x(x>x(minx_index1)));%The second minimal coordinate of 4 x coordinate
[~,minx_index2] = find(x == minx2);

ld_index = (y(minx_index2) >= y(minx_index1))*minx_index2 + (y(minx_index2) < y(minx_index1))*minx_index1;
lu_index = (y(minx_index2) >= y(minx_index1))*minx_index1 + (y(minx_index2) < y(minx_index1))*minx_index2;

%max_index contains the two right points
[~,max_index] = find(x>(max(x(minx_index1),x(minx_index2)))); 
rd_index = (y(max_index(1)) >= y(max_index(2)))*max_index(1) + (y(max_index(1)) < y(max_index(2)))*max_index(2);
ru_index = (y(max_index(1)) >= y(max_index(2)))*max_index(2) + (y(max_index(1)) < y(max_index(2)))*max_index(1);

point = [[Middle(1),Middle(2)];...
    x(ld_index),y(ld_index);...
    x(rd_index),y(rd_index);...
    x(lu_index),y(lu_index);...
    x(ru_index),y(ru_index)];

Xc=point(1,1);
Yc=point(1,2);

leftdownpoint=[point(2,1),point(2,2)];
rightdownpoint=[point(3,1),point(3,2)];
leftuppoint=[point(4,1),point(4,2)];
rightuppoint=[point(5,1),point(5,2)];
a = rightuppoint - leftuppoint;
b = rightdownpoint - leftdownpoint;
l1 = norm(a);
l2 = norm(b);
L = (l1+l2)/2;
w1 = norm(leftuppoint-leftdownpoint);
w2 = norm(rightdownpoint-rightuppoint);
W = (w1+w2)/2;
alpha = atand(-n1/n2);

LW = [Xc,Yc,L,W,alpha];
end