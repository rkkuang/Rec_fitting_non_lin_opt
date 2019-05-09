function cn = LW2cn(LW)
%The LW2cn() function computes the coefficents (c1,c2,c3,c4,n1,n2) of a
%rectangle from coefficients (Xc,Yc,L,W,alpha)
%   input: 
%       A vector LW = [Xc,Yc,L,W,alpha];
%       Xc,Yc: The position of the center point of a rectangle
%       L,W: The size of the rectangle (in pixels)
%       alpha: The angle of the rectangle to the horizontal (in degrees)
%   output: 
%       cn = [c1,c2,c3,c4,n1,n2]:coefficients which determin a rectangle

% Version: 1.0 2018.08.20 by rkkuang
Xc0 = LW(1);
Yc0 = LW(2);
L0 = LW(3);
W0 = LW(4);
alpha0 = LW(5);

talpha = tand(alpha0);
calpha = cosd(alpha0);
salpha = sind(alpha0);
coe = sqrt(1+(talpha^2));
n1 = talpha/coe;
n2 = -1/coe;
c1 = (Yc0 - talpha*Xc0 + W0/2/calpha)/coe;
c2 = (Yc0 - talpha*Xc0 - W0/2/calpha)/coe;
c3 = -talpha*(Yc0 + 1/talpha*Xc0 + L0/2/salpha)/coe;
c4 = -talpha*(Yc0 + 1/talpha*Xc0 - L0/2/salpha)/coe;

cn = [c1,c2,c3,c4,n1,n2];
end