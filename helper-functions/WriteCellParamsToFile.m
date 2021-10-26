function WriteCellParamsToFile(directory_row, cell_params)
trial_folder_path = BuildTrialFolderPath(directory_row.date{1}, ...
                                         directory_row.cell_name{1}, ...
                                         directory_row.trial_name{1});
cell_params_save_filename = fullfile(trial_folder_path, 'cell_params.csv');
WriteStructureToFile(cell_params, cell_params_save_filename)

end