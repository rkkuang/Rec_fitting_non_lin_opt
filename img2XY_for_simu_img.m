function [X,Y ,x0] = img2XY_for_simu_img(im_captured,imgL,imgW)

canny_edge=edge(im_captured,'Canny');

img_re = canny_edge;

img_re = img_re>0.5;
figure()
set(gcf,'color','white');
imshow(img_re,'InitialMagnification','fit');

axis on;
title('Detected edge from original rectangle region','fontsize',14);

[y,x] = find(img_re==1);

[U,R,D,L,x0] = accurate_find_line(x,y);

X = [U(:,1);R(:,1);D(:,1);L(:,1)];%colum vector
Y = [U(:,2);R(:,2);D(:,2);L(:,2)];
sizeX = size(X,1);
if sizeX>400
step = floor(sizeX/300);
% Reduce the problem size
X = X(1:step:end);
Y = Y(1:step:end);

figure()
set(gcf,'color','w');
plot(X,Y,'b.');%hold on
title('The edge points of the rectangle after sampling','fontsize',14);
axis([0, imgL, 0, imgW]);
set(gca,'ydir','reverse');%
set(gca,'FontSize',16);
hold off;
end