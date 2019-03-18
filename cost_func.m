function cost_fvalue = cost_func(cn,X,Y)
%The cost_func() function defines the cost function of the rectangle fitting problem,
% is used for Matlab function: fmincon
%   input: 
%       cn = [c1,c2,c3,c4,n1,n2]:coefficients which determin a rectangle
%       X,Y: The coordinates of a group of points
%   output: 
%        cost_fvalue: The cost value of the continuous cost function.
%Version:1.0 2018.09.03 by rkkuang

c1 = cn(1);
c2 = cn(2);
c3 = cn(3);
c4 = cn(4);
n1 = cn(5);
n2 = cn(6);

sizeX = size(X,1);
XY = [X';Y'];
c1row = ones(1,sizeX);

cMatrix = [c1row*c1;c1row*c2;c1row*c3;c1row*c4];
dMatrix = cMatrix + [n1,n2;n1,n2;-n2,n1;-n2,n1]*XY;
dMatrix = abs(dMatrix);

max_d = max(max(dMatrix));

L = (max_d^2/590)^0.5;% L is the sigma of the continous cost function in that paper

dL = -(dMatrix.^2)/(L^2);

expdL = exp(dL);
cost_fvalue = -sum(expdL(:));
end