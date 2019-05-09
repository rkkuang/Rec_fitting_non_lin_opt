function X = compcorner( Xc,Yc,L,W,alpha )
%The compcorner() function is for computing the fours corners of a
%rectangle from its 5 variables (Xc,Yc,alpha,L,W) 
%   input: 
%       Xc,Yc: The position of the center point of a rectangle
%       L,W: The size of the rectangle (in pixels)
%       alpha: The angle of the rectangle to the horizontal (in degrees)
%   output: 
%        X: Positions of the 4 corners of a rectangle
%Version:1.0 2018.09.03 by rkkuang
if abs(alpha-eps)<=eps
corner1 = [Xc-L/2;Yc+W/2];
corner2 = [Xc-L/2;Yc-W/2];
corner4 = [Xc+L/2;Yc+W/2];
corner3 = [Xc+L/2;Yc-W/2];
    
else
k1 = tand(alpha);
k2 = 1/tand(alpha);

coe1 = Yc - k1*Xc;
coe2 = W/2/cosd(alpha);
coe3 = Yc + k2*Xc;
coe4 = L/2/sind(alpha);
b1 = coe1 + coe2;
b2 = coe1 - coe2;
b3 = coe3 + coe4;
b4 = coe3 - coe4;

corner1 = [-k1,1;k2,1]\[b1;b3];
corner2 = [k2,1;-k1,1]\[b3;b2];
corner3 = [-k1,1;k2,1]\[b2;b4];
corner4 = [k2,1;-k1,1]\[b4;b1];
end
X = [corner1 corner2 corner3 corner4];

end