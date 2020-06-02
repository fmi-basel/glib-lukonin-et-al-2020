This repository contains the edge-based segmentation code used in the paper "Phenotypic landscape of intestinal organoid regeneration" by Lukonin et al. 2020. The code has been validated to run in MatLab version 2017b.

This repository contains the code necessary to produce labeled segmentation maps that can be used to extract image features.

Following scripts in the repository require user input:

organoid_segmentation_screen.m:
Main function that runs the workflow, output is a 16-bit labeled image with intensity-coded object ID.

In order to run the worflow, following User input is required:

 - install_path, directory with the repository code
	path to the imaging data is expected to have the following structure: 
	[data_path]\[username]\[experiment_ID]\
 - data_path, file path to the Test_Images directory provided in the repository
 - username, default includes 'testuser'
 - experiment_ID, default set to 'test_data_160909IL003'
 - experiment_ID folder should contain following subfolders:
 - MIPs_Overviews*, should contain Maximum intensity projection images, expected finame pattern is: 
[Prefix(optional)]_[plate_name]_[well_name]_*[channel_name]
 - SIPs_Overviews*, should contain Maximum intensity projection images, expected finame pattern is: 
[Prefix(optional)]_[plate_name]_[well_name]_*[channel_name]
 * can be any combination of characters and digits and plate_name should be 11 characters long.

plate_name , default set to  '160909IL003'

settings_file_demo.m:

contains setting input for the edge-based segmentation and object filtering.

The package performs edge-based segmentation on the Maximum intensity image provided, writing out a labeled image into the outDir.


