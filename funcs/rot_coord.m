function new_XY = rot_coord(XY,theta)
%The rot_coord() function is used for coordinates rotation
%input: XY: the coordinates matrix, Nx2, N is the number of points
%      theta: the angle you want to rotate, in degree
%      output: new_XY: the coordinates matrix after rotate
% Version1: 20181016 by rkkuang
if theta ==0 
    new_XY = XY;
else
    rotMatrix = [cosd(theta) sind(theta);-sind(theta) cosd(theta)];
    new_XY = XY*rotMatrix;
end
end