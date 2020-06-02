function [input_args] = settings_file_demo(input_args)

% This is the setting file for processing the experiment steps

   input_args.dir1 = [input_args.rootDir,input_args.username,input_args.experiment_ID];
   temp_dir1 = dir([input_args.dir1,filesep,'SIPs_Overviews*']);
   input_args.intensity_images_dir =  [input_args.dir1, temp_dir1.name]; %projection type for feature extraction
   temp_dir2 = dir([input_args.dir1,filesep,'MIPs_Overviews*']);
   input_args.perchannelMIPdir = [input_args.dir1,temp_dir2.name]; % MIP projections
   temp_dir3 = dir([input_args.dir1,filesep,'SIPs_Overviews*']);
   input_args.perchannelSIPdir = [input_args.dir1,temp_dir3.name]; % SIP projections

   
% Params for edge_based_segmentation

    input_args.minarea = 7999; % minimum area of an organoid
    input_args.minsolidity = 0.0;
    
    input_args.LineStrelSize = 3; %size of the line StrEL for edge enhancement
    
    input_args.ErodeKernelSize = 2; %erosion kernel size
    input_args.loopcyclesErosion=5; %erosion loop cycles
    input_args.DilateKernelSize = 4; %dilation kernel size
    input_args.loopcyclesDilation=2; %dilation loop cycles
    
    input_args.imposeMinVal=30; %variable for strigency of minima imposing in the threshold step
    input_args.organoid_segmentation_threshold = 15000; % threshold for organoid segmentation
    input_args.channel_numberSIP = 4; % channel to use for organoid detection
    input_args.channel_numberMIP = 1;
   
    input_args.search_strSIP = {'*C04.tif'};  % channel string to use for organoid detection
    input_args.search_strMIP = {'*C01.tif'};  % channel string to use for organoid detection
    input_args.SelectedWells =[];   % leave it as an empty if you want to process all wells
    input_args.border_object_axis_length = 75; % the length of the edge object for ignoring the object
    input_args.organoid_border_erosion_factor = 10; % how much in pixels border should be eroded when organoids are touching
        

end


