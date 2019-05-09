function cost_fvalue = cost_func4ang0(para,X,Y)
%The cost_func() function defines the cost function of the rectangle fitting problem,
% is used for Matlab function: fmincon
%   input: 
%       cn = [c1,c2,c3,c4,n1,n2]:coefficients which determin a rectangle
%       X,Y: The coordinates of a group of points, Nx1
%   output: 
%        cost_fvalue: The cost value of the continuous cost function.
%Version:1.0 2018.09.03 by rkkuang

X_c = para(1);
Y_c = para(2);
L = para(3);
W = para(4);

sizeX = size(X,1);
XY = [X';Y'];
c1row = ones(1,sizeX);

cMatrix = [c1row*(-Y_c-W/2);c1row*(-Y_c+W/2);c1row*(-X_c+L/2);c1row*(-X_c-L/2)];
dMatrix = cMatrix + [0,1;0,1;1,0;1,0]*XY;
dMatrix = abs(dMatrix);

%cost_fvalue = min(dMatrix(:));%190416 wrong
cost_fvalue = sum(min(dMatrix));


%max_d = max(max(dMatrix));
%L = (max_d^2/590)^0.5;% L is the sigma of the continous cost function in that paper
%dL = -(dMatrix.^2)/(L^2);
%expdL = exp(dL);
%cost_fvalue = -sum(expdL(:))+eps;
end