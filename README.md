In order to run, following User input is required:

install_path, directory with the repository code

path to the imaging data is expected to have the following structure: 
[data_path]\[username]\[experiment_ID]\

data_path, 
username,
experiment_ID,
plate_name ,

experiment_ID folder should contain following subfolders:

 - MIPs_Overviews*, should contain Maximum intensity projection images, expected finame pattern is: 

[Prefix(optional)]_[plate_name]_[well_name]_*[channel_name]

 - SIPs_Overviews*, should contain Maximum intensity projection images, expected finame pattern is: 

[Prefix(optional)]_[plate_name]_[well_name]_*[channel_name]

 * can be any combination of characters and digits

The script performs edge-based segmentation on the Maximum intensity image provided, writing out a labeled image into the outDir
