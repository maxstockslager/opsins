function cell_params = ReadCellParams(data_directory_row)
trial_folder_path = BuildRunFolderPath(data_directory_row);
SEARCH_STRING = 'memtest_Vclamp_cellparams';
file_paths = FindFilepathsMatchingString(trial_folder_path, SEARCH_STRING);

file_number = 1;
current_file_path = file_paths{file_number};
raw_cell_params = ReadCellParamsFromFile(current_file_path); 

cell_params = struct(...
    'date', data_directory_row.('date'), ...
    'sample_name', data_directory_row.('sample_name'), ...
    'cell_name', data_directory_row.('cell_name'), ...
    'trial_name', data_directory_row.('trial_name'), ...
    'Ihold', raw_cell_params.Ihold, ...
    'Rm', raw_cell_params.Rm, ...
    'Ra', raw_cell_params.Ra, ...
    'Cm', raw_cell_params.Cm, ...
    'tau', raw_cell_params.tau, ...
    'Rt', raw_cell_params.Rt ...
);
end