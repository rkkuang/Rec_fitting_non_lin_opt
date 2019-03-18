%The simu_rec_fit_test.m script is used to test the rectangle fitting
%method by first generating a simulated image with a rectangle region in
%it, then compute the parameters of that rectangle to test the locating 
%and size measuring accuracy of this method.


%Simulated image size 
imgL = 512;
imgW = 512;
simu_img_para = [imgL,imgW];

%The parameters of the rectangle in the simulated image.
rec_center_X = 250;
rec_center_Y = 273;
recL = 397;
recW = 298;
rec_ang = 21;

simu_rec_para = [rec_center_X,rec_center_Y,recL,recW,rec_ang];
simu_img = rec_region_img(simu_img_para,simu_rec_para);

figure(1);
set(gcf,'color','white');
imshow(simu_img,'InitialMagnification','fit');
axis on;
title_text = {strcat('Simulated image size:',num2str(imgL),'\times',...
    num2str(imgW),',rectangle parameters:'),...
    strcat('(L,W):',num2str(recL),'\times',num2str(recW),',(X_c,Y_c):(',num2str(rec_center_X),',',num2str(imgW-rec_center_Y),...
    '),angle=',num2str(rec_ang),'\circ')};
title(title_text,'fontsize',14);

[X,Y ,x0] = img2XY_for_simu_img(simu_img,imgL,imgW);
rec_para = Rec_fitting(X,Y,x0,1,imgL,imgW);
rec_para(5) = -rec_para(5);

simu_rec_para(2)=imgW-rec_center_Y;
disp('res: setted parameters(above) and computed parameters(bottom)');
res = [simu_rec_para;rec_para]