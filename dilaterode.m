function edgeimg = dilaterode(bw,flag,dilatetime,erodetime,DEcoe)
%The dilaterode() function detect the edge poitns of a binary image
%   input: 
%       bw: a binary image
%       flag: choose weather erode first or dilate first to handle the binary image
%       dilatetime: the times of the dilate processes
%       erodetime: the times of the erode processes
%       DEcoe: The 
%   output: 
%        D: the distance of one single point to the fitted rectangle
% Version: 1.0 2018.08.20 by rkkuang

se1=strel('disk',DEcoe);%Morphological structuring element
% creates a disk-shaped structuring element, where DEcoe specifies the radius
B=[0 0 1 0 0;
0 1 1 1 0;
1 1 1 1 1;
0 1 1 1 0;
0 0 1 0 0];
switch flag
    case 1%erode then dilate
        A21 = bw;
        for i = 1:erodetime
            A21=imerode(A21,se1);
        end
        A31 = A21;
        for i = 1:erodetime
            A31=imdilate(A31,B);
        end
        edgeimg = A31;
    case 2%dilate then erode
            A22 = bw;
            for i = 1:dilatetime
                A22=imdilate(A22,B);
            end
            A32 = A22;
            for i = 1:dilatetime
                A32=imerode(A32,se1);
            end
            edgeimg = A32;
end