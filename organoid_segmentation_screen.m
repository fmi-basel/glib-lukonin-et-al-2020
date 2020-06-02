function organoid_segmentation_screen(input_args)

% Main function that runs the workflow, output is a 16-bit labeled image with intensity-coded object ID
% output image can be used for image extraction from the original image input

%%%%%%%%%%%%%%%%%% Plate information %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%path should be structured as: data_path\username\experiment_ID 

install_path=['path_to_repository',filesep];
data_path=['path_to_testdata',filesep];
username = ['testuser',filesep];
experiment_ID = ['test_data_160909IL003',filesep];
plate_name = '160909IL003';

folder_name=([data_path,username,experiment_ID,filesep]);
input_args.outDir = [folder_name,filesep]; %ouput can be placed elsewhere

%%%%%%%%%%%%%%%%%%%%% End of User input block %%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(genpath(install_path))

rootDir = data_path;
input_args.Skipped_Wells = {};
input_args.Skipped_Fields = {};
input_args.Skipped_ZPlanes = {};


input_args.rootDir = rootDir;
input_args.username = username;
input_args.experiment_ID = experiment_ID;
input_args.plate_name = plate_name;
       

input_args.dir3 = [rootDir, username, experiment_ID];
disp(['The directory ', input_args.dir3, ' is being processed ...'])

reports_folder = [input_args.outDir, 'Reports', filesep];
if(~exist(reports_folder, 'dir'))
    mkdir(reports_folder)
end
input_args.t1 = strrep(strrep(sprintf(datestr(now)),' ','_'),':','_');

strTiffPath1 =  [input_args.rootDir, input_args.username, input_args.experiment_ID];  
input_args.strPath = [strTiffPath1, filesep];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Organoid Segmentation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    diary([input_args.rootDir,input_args.username,input_args.experiment_ID, 'Reports', filesep,'Organoid Segmentation_reports.csv'])
    
    [input_args] = settings_file_demo(input_args);
    organoid_analysis_screen(input_args);
    disp('Organoid segmentation and measurements of the plate are done successfully!');
    diary off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% FINISH REPORTING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

diary([input_args.rootDir,input_args.username,input_args.experiment_ID, 'Reports', filesep,'All_reports.csv'])
disp('Completed successfully!');
diary off;



