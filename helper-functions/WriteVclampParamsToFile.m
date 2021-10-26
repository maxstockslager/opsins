function WriteVclampParamsToFile(directory_row, vclamp_params)
trial_folder_path = BuildTrialFolderPath(directory_row.date{1}, ...
                                         directory_row.cell_name{1}, ...
                                         directory_row.trial_name{1});
vclamp_params_save_filename = fullfile(trial_folder_path, 'vclamp_params.csv');

WriteStructureToFile(vclamp_params, vclamp_params_save_filename)

end