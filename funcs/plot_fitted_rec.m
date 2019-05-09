function plot_fitted_rec(LW,imgL,imgW)
% The plot_fitted_rec() function is used to show all the points and the fitted rectangle
%   input: 
%       A vector LW = [Xc,Yc,L,W,alpha];
%       Xc,Yc: The position of the center point of a rectangle
%       L,W: The size of the rectangle (in pixels)
%       alpha: The angle of the rectangle to the horizontal (in degrees)
%       imgL,imgW is the size of the image 
% Version: 1.0 2018.08.20 by rkkuan


Xc = LW(1);
Yc = LW(2);
L = LW(3);
W = LW(4);
alpha = LW(5);

C = compcorner(Xc,Yc,L,W,alpha );

C = [C C(:,1)];
figure()
set(gcf,'color','w');

plot(C(1,:), C(2,:),'r','linewidth',2);%hold on
title('Rectangle fitting result','fontsize',36);

axis([0, imgL, 0, imgW]);
set(gca,'ydir','reverse');
set(gca,'FontSize',36);
hold off;
end