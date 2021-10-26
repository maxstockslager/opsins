clear all, close all
addpath('helper-functions')

BASE_FILEPATH = 'D:\data\patching\';
DATA_DIRECTORY_FILEPATH = 'D:\data\patch-data-directory.xlsx';
SHEET_TO_READ = '20211025';
PARAMS = struct(...
    'MOVING_AVERAGE_WINDOW_SEC', 0.05, ... % sec
    'THRESHOLD_CURRENT_STEP',  15, ... % assume this is positive. NOT USED currently, see AnalyzeSingleSweep
    'BUFFER_SEC', 0.1, ... % sec
    'TRANSIENT_END_BUFFER_SEC', 0.06 ... % sec
);

%%
data_directory = readtable(DATA_DIRECTORY_FILEPATH, 'Sheet', SHEET_TO_READ);
fprintf('found %.0f cells in data directory\n', height(data_directory));

for CELL_NUMBER = 1:height(data_directory)
    current_date = data_directory{CELL_NUMBER, 'date'}{1};
    current_cell_name = data_directory{CELL_NUMBER, 'cell_name'}{1};

    % for each cell in the directory,
    CELL_FOLDER = fullfile(BASE_FILEPATH, current_date, current_cell_name);
    fprintf('current cell: %s\\%s\n', current_date, current_cell_name);       
    fprintf('   -cell number %.0f/%.0f\n', CELL_NUMBER, height(data_directory));
    fprintf('   -cell ID: %s\n', data_directory{CELL_NUMBER, 'cell_id'}{1});
    fprintf('   -cell folder: %s\n', CELL_FOLDER);

    % search for all the sweep folders
    sweep_folder_names = FindFoldersMatchingString(CELL_FOLDER, 'sweep');
    sweep_folders = FindFolderPathsMatchingString(CELL_FOLDER, 'sweep');

    fprintf('   -found %.0f sweeps in this cell''s folder:\n', numel(sweep_folders));

    % for each sweep in this cell's folder,
    for sweep_number = 1:numel(sweep_folders)

        
        
        SWEEP_FILEPATH = sweep_folders{sweep_number};
        fprintf('      -processing sweep: %s\n', sweep_folder_names{sweep_number});

        try
            % read voltage from sweep filename
            sweep_label = GetSweepIDFromFolderPath(SWEEP_FILEPATH, '\');

            % get list of Vclamp files (only expect one) 
            replicate_file_paths = FindFilepathsMatchingString(...
                SWEEP_FILEPATH, ...
                'protocol_Vclamp_rec');

            % Analyze each replicate and concatenate if there are multiple sweeps
            sweep_summaries = AnalyzeSweepsList(replicate_file_paths, PARAMS);
            vclamp_params = ExtractVclampParamsFromSummariesList(sweep_summaries); 

            WriteStructureToFile(vclamp_params, ...
                fullfile(SWEEP_FILEPATH, 'vclamp_params.csv'))
        catch
            fprintf('**encountered error, continuing to next sweep\n')
        end

    end
end













