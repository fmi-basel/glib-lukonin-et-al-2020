function [output_args] = generate_labeled_map(input_args)


    [labeled1] = edge_based_segmentation(input_args);
    %output is a labeled image for region props extraction
    
    regions1 = regionprops(labeled1, 'all');
    areas = [regions1.Area];
    sindex = [regions1.MinorAxisLength] ./ [regions1.MajorAxisLength];
    clear labeled1
    
    [~,c,~] = find(areas > input_args.minarea);
    regions2 = regions1(c);
    im2 = zeros(size(input_args.OrigImageSIP),'uint16');
    for i = 1: numel(regions2)
        im2(regions2(i).PixelIdxList) = i;
    end
   
   input_args.LabelledImage = im2;
   clear im2;
   
     % saving images

     filename2 = [input_args.out_dir, filesep, 'Labelled_',input_args.image_name(1:end-3),'png'];
     imwrite(input_args.LabelledImage,filename2);
    
     
     
end

