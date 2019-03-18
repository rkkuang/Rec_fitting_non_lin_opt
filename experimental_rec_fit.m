%The experimental_rec_fit.m script is used to show the experimental results
%of the locating and size measuring of micro work pieces.

%The real physical size of 22 micro work pieces measured by a vernier
%caliper, in mm
%[index, Length, Width]
realsize = [
1, 18.044, 6.010;
2, 18.070, 6.007;
3, 18.066, 6.009;
4, 18.041, 6.009;
5, 18.069, 6.006;
6, 18.038, 6.014;
7, 18.071, 6.007;
8, 18.056, 6.010;
9, 18.071, 6.008;
10, 18.032, 6.011;
11, 18.060, 6.011;
12, 18.103, 6.008;
13, 18.073, 6.010;
14, 18.053, 6.007;
15, 18.068, 6.009;
16, 18.029, 6.011;
17, 18.037, 6.010;
18, 18.092, 6.009;
19, 18.061, 6.009;
20, 18.033, 6.008;
21, 18.027, 6.010;
22, 18.062, 6.010;
];

count = 1;
realL = [];
realW = [];
pixelL = [];
pixelW = [];
imgL = 2592;
imgW = 1944;
for i=1:22
        realL(count) = realsize(i,2);
        realW(count) = realsize(i,3);
        imgname = strcat('imgs/',num2str(i),'.bmp');
        [X,Y ,x0] = img2XY_rec_fitting(imgname);
        
        para1 = Rec_fitting(X,Y,x0,0,imgL,imgW);%Xc,Yc,L,W,alpha
        pixelL(count) = para1(3);
        pixelW(count) = para1(4);
        count = count+1;
end

n=1;
[kL,bL] = linear_regression(pixelL,realL,n);% k b
[kW,bW] = linear_regression(pixelW,realW,n);
figure();
set(gcf,'color','w');
scatter(pixelL,realL,45,'r*');hold on;

errorbar(pixelL,pixelL*kL+bL,(pixelL*kL+bL - realL),'-o','linewidth',2);
title('Real length and Computed pixel length','fontsize',36);
ylabel('Real size/mm');
xlabel('Computed pixel size/pixel');
axis on;
set(gca,'FontSize',36);

figure();
set(gcf,'color','w');
scatter(pixelW,realW,45,'r*');hold on;

errorbar(pixelW,pixelW*kW+bW,(pixelW*kW+bW - realW),'-o','linewidth',2);
title('Real width and Computed pixel width','fontsize',36);
ylabel('Real size/mm');
xlabel('Computed pixel size/pixel');
axis on;
set(gca,'FontSize',36);