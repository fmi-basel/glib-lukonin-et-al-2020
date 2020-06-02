function [im_eroded] = edge_based_segmentation ( input_args )

%create image gradients

[im_erodedDAPI, ~] = imgradient(input_args.OrigImageMIP);
aa=multithresh(im_erodedDAPI,2);
clear im_erodedDAPI

bb=multithresh(input_args.OrigImageMIP,2);
thr=(imquantize(input_args.OrigImageMIP,aa)==2);
bgimg=ones(size(input_args.OrigImageMIP));
bgimg=bgimg.*thr;

%bgimg = imdilate(bgimg, [se90 se0]);
bgimg =bwareaopen(bgimg,input_args.minarea);
bgimg=imfill(bgimg,'holes');

BWs = edge(input_args.OrigImageSIP,'canny');
%line strel definition to extend edge
se90 = strel('line', input_args.LineStrelSize, 90);
se0 = strel('line', input_args.LineStrelSize, 0);

BWs = imdilate(BWs, [se90 se0]);
BWs = imfill(BWs, 'holes');

%erosion kernel
seD = strel('diamond', input_args.ErodeKernelSize);
%dilation kernel
seD2 = strel('diamond', input_args.DilateKernelSize);


    for i=1:input_args.loopcyclesErosion
        BWfinal = imerode(BWs,seD);
    end

clear BWs
BWfinal =bwareaopen(BWfinal, input_args.minarea);

    for i=1:input_args.loopcyclesDilation
        BWfinal = imdilate(BWfinal,seD2);
    end

%here we add two binary images to make sure we do not lose objects where
%the edge is not continous
%need to run the watershed 2x, first time here, second one before watershed

BW1 = bwlabel (bgimg);
object_labels = [1:max(BW1(:))];

th1 = input_args.border_object_axis_length;

%identify objects with field edge artifacts, discard
Objects_cut_x = zeros(size(object_labels));
Objects_cut_y = zeros(size(object_labels));

for i = 1: numel(object_labels)
    
    BW = BW1 == object_labels(i);
    [B,~,~,~] = bwboundaries(BW);
    boundary = cell2mat(B(1));
    
    B1 = abs(diff(boundary(:,1)));
    B2 = abs(diff(boundary(:,2)));

    [indices1] = vector_to_indices(B1',th1);
    [indices2] = vector_to_indices(B2',th1);

    if numel(indices1) > 0 
        Objects_cut_x(i) = 1;
    end

    if numel(indices2) > 0 
        Objects_cut_y(i) = 1;
    end
    
regions2 = regionprops(BW1, 'all');

if  Objects_cut_x(i) == 1
    im_eroded(regions2(i).PixelIdxList) = 0;
end

if  Objects_cut_y(i) == 1
    im_eroded(regions2(i).PixelIdxList) = 0; 
end
end

clear object_labels
im_eroded=bgimg | BWfinal;

clear bgimg
clear BWfinal

im_eroded =bwareaopen(im_eroded,input_args.minarea);
im_eroded = imfill(im_eroded, 'holes');

%need to implement removal of fragmented objects before watershed

BW1 = bwlabel (im_eroded);
object_labels = [1:max(BW1(:))];

th1 = input_args.border_object_axis_length;
 
Objects_cut_x = zeros(size(object_labels));
Objects_cut_y = zeros(size(object_labels));

for i = 1: numel(object_labels)
    
    BW = BW1 == object_labels(i);
    [B,~,~,~] = bwboundaries(BW);
    boundary = cell2mat(B(1));
    
    B1 = abs(diff(boundary(:,1)));
    B2 = abs(diff(boundary(:,2)));

    [indices1] = vector_to_indices(B1',th1);
    [indices2] = vector_to_indices(B2',th1);

    if numel(indices1) > 0 
        Objects_cut_x(i) = 1;
    end

    if numel(indices2) > 0 
        Objects_cut_y(i) = 1;
    end
    
regions3 = regionprops(BW1, 'all');

if  Objects_cut_x(i) == 1
    im_eroded(regions3(i).PixelIdxList) = 0;
end

if  Objects_cut_y(i) == 1
    im_eroded(regions3(i).PixelIdxList) = 0; 
end

end
%figure()
% imagesc(im_eroded)

%kernel is hard-coded, can be replaced with an argument

G = fspecial('gaussian',[15 15],5);
bw = imfilter(im_eroded>0,G,'same');

%watersheding step follows
D = -bwdist(~im_eroded);
Ld = watershed(D);
bw2 = bw;
bw2(Ld == 0) = 0;
%the minima imposing 
mask = imextendedmin(D,input_args.imposeMinVal);
D2 = imimposemin(D,mask);
Ld2 = watershed(D2);
bw3 = bw;
bw3(Ld2 == 0) = 0;

im_eroded=bwlabel(bw3);
clear bw3

end




 
