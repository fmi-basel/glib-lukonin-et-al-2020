function organoid_analysis_screen_parallel( input_args )

% Created on 12-Aug-2016 by Dr. Saadia Iftikhar, saadia.iftikhar@fmi.ch
% ---------------------------------------------------------------------

input_args.dir1 = input_args.strPath;
input_args.out_dir = [input_args.outDir, 'Organoid_Image_Results', '_' ,input_args.t1, filesep];

if (~exist('out_dir','dir'))
    mkdir(input_args.out_dir)
end

tic

all_features = [];
all_headers =  [];

for i = 1:numel(input_args.search_strSIP)
    search_str = char(input_args.search_strSIP{i});
    organoids_imagesSIP = dir([input_args.perchannelSIPdir, filesep, char(input_args.search_strSIP)]);
    organoids_imagesMIP = dir([input_args.perchannelMIPdir, filesep, char(input_args.search_strMIP)]);
       
    if numel(input_args.SelectedWells) > 0
         clear organoids_images
        for k = 1: numel(input_args.SelectedWells)
            well_name = char(input_args.SelectedWells{k});
            organoids_images(k) = dir([input_args.organoid_dir, filesep, '*_', well_name, '_*', search_strSIP]);
        end
    else
        organoids_imagesSIP = organoids_imagesSIP;
        organoids_imagesMIP = organoids_imagesMIP;
    end
    
 
for j = 1: numel(organoids_imagesSIP)
         j
       [organoid_output_args] = segmentation_worker( input_args, ...
                                            organoids_imagesSIP,organoids_imagesMIP, j);


end
 
end

end