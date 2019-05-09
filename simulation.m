%The simulation.m script is used to test the rectangle fitting
%method by first generating a simulated image with a rectangle region in
%it, then compute the parameters of that rectangle to test the locating 
%and size measuring accuracy of this method.

%down sampling factor:
N = 10;

%Simulated image size 
imgL = 512;
imgW = 512;
simu_img_para = [imgL,imgW];
simu_img_para = simu_img_para*N;

%The parameters of the rectangle in the simulated image.
rec_center_X = 250;
rec_center_Y = 239;

recL = 397;
recW = 298;

d_ang = 0.5;
simL = [];
simW = [];

psf = ones(N)./(N^2);

simu_img = zeros(imgW,imgL);

filename = 'temp.txt';
banchmark = [rec_center_X,rec_center_Y,recL,recW];

save(filename,'banchmark','-ascii','-append');
file = fopen(filename,'a');
fprintf(file,'\n---------------------------\nsimulation result with different angles\n---------------------------\n');
fclose(file);
rec_ang = 21;
drop = 0;% Do not drop corner points
L0coe = 1;% Control the estimation of sigma0 = sqrt(2*L0)/L0coe;
for ang_i = 1:length(rec_ang)
simu_rec_para = [rec_center_X,rec_center_Y,recL,recW,rec_ang(ang_i)];
simu_rec_para(1:4)=simu_rec_para(1:4)*N;
simu_img0 = rec_region_img(simu_img_para,simu_rec_para);
%Down sampling the high resolution image to get a low resolution image
temp = conv2(simu_img0,psf,'same');
simu_img = temp(ceil(N/2):N:end,ceil(N/2):N:end);
[X,Y ,x0] = img2XY_for_simu_img(simu_img,drop);
rec_para = Rec_fitting(X,Y,x0,1,imgL,imgW,L0coe);
simL(ang_i)=rec_para(3);
simW(ang_i)=rec_para(4);
rec_para_out = [rec_para,rec_ang(ang_i)];
save(filename,'rec_para_out','-ascii','-append');
end

mean_res = [mean(simL),mean(simW)];
std_res = [std(simL),std(simW)];
diff = [mean(simL)-recL,mean(simW)-recW];

file = fopen(filename,'a');
fprintf(file,'\n---------------------------\nAll simuL\n---------------------------\n');
fclose(file);
save(filename,'simL','-ascii','-append');
file = fopen(filename,'a');
fprintf(file,'\n---------------------------\nAll simuW\n---------------------------\n');
fclose(file);
save(filename,'simW','-ascii','-append');

file = fopen(filename,'a');
fprintf(file,'\n---------------------------\nmean, diff and std\n---------------------------\n');
fclose(file);
save(filename,'mean_res','-ascii','-append');
save(filename,'diff','-ascii','-append');
save(filename,'std_res','-ascii','-append');

% figure();
% set(gcf,'color','white');
% imshow(simu_img,'InitialMagnification','fit');
% axis on;
% set(gca,'fontsize',36);
% title_text = {strcat('Simulated image')};
% title(title_text,'fontsize',36);