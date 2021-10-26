function run_folder_path = BuildRunFolderPath(data_directory_row)
    run_folder_path = fullfile(data_directory_row.('base_directory'){1}, ...
                               data_directory_row.('folder_name'){1});
end