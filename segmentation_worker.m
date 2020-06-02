function [ organoid_output_args] = segmentation_worker(input_args, organoids_imagesSIP,organoids_imagesMIP, j)
%function for running edge-based segmentation, can be used for parallelization of the process.

  input_args.organoid_dir = input_args.intensity_images_dir;

try 
   
            strFileName = [organoids_imagesSIP(j).name(1:end-10), '*',];
                   
            intensity_images = dir([input_args.intensity_images_dir, filesep, strFileName]);
            if numel(intensity_images) > 0

              
                    input_args.OrigImageMIP = imread([input_args.perchannelMIPdir, filesep, organoids_imagesMIP(j).name]);
                    input_args.OrigImageSIP = imread([input_args.organoid_dir, filesep, organoids_imagesSIP(j).name]);
                  
                input_args.input_dir = input_args.organoid_dir;
                input_args.image_name = [organoids_imagesSIP(j).name];
                input_args.intensity_images_dir = input_args.intensity_images_dir;
                input_args.intensity_images = intensity_images;

                [organoid_output_args] = generate_labeled_map(input_args);

            end
catch
    organoid_output_args = [];
end
end