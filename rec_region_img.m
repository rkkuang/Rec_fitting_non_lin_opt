function res_img = rec_region_img(img_paras,rec_paras)
%The function rec_region_img() is used to generate a simulated image with a
%rectangle region in that image
%   input: 
%       img_paras: The pixel size of the generated image
%       rec_paras: The parameters of the rectangle region
%   output: 
%       The result simulated rectangle region image

% Version: 1.0 2019.01.24 by rkkuang

imgL = img_paras(1);
imgW = img_paras(2);
rec_center_X = rec_paras(1);
rec_center_Y = rec_paras(2);
recL = rec_paras(3);
recW = rec_paras(4);
rec_ang = rec_paras(5);


res_img = zeros(imgW,imgL);%The image we want to generate 
rec_x_range = (-recL/2:recL/2)';
rec_y_range = (-recW/2:recW/2)';

%The original coordinates of points in a rectangle region, centered at (0,0)
coords_of_points = zeros((recW+1)*(recL+1),2);

final_coords_of_points = zeros((recW+1)*(recL+1),2);

k = 0;
for i = 1:recW+1
    for j = 1:recL+1
        k=k+1;
        coords_of_points(k,:) = [rec_x_range(j),rec_y_range(i)];
    end
end

%rotate the coordinates of a angle
rot_coords_of_points = rot_coord(coords_of_points,rec_ang);

%Add the offset to change the center of the rectangle
final_coords_of_points(:,1) = rot_coords_of_points(:,1)+rec_center_X;
final_coords_of_points(:,2) = rot_coords_of_points(:,2)+rec_center_Y;

int_xy = zeros((recW+1)*(recL+1),2);
int_xy(:,1) = fix(final_coords_of_points(:,1));
int_xy(:,2) = fix(final_coords_of_points(:,2));

for i = 1:length(int_xy)
    res_img(imgW-int_xy(i,2),int_xy(i,1))=1;
end

for i = 1:imgW
   temp = find(res_img(i,:)==1);
   min_index = min(temp);
   max_index = max(temp);
   res_img(i,min_index:max_index)=1;
end
end