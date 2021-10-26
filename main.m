clear all, close all
addpath('helper-functions')

DATA_DIRECTORY_FILEPATH = 'D:\data\patch-data-directory.xlsx';
SHEET_TO_READ = '20211014';

params = struct(...
    'MOVING_AVERAGE_WINDOW_SEC', 0.05, ... % sec
    'THRESHOLD_CURRENT_STEP',  15, ... % assume this is positive. NOT USED currently, see AnalyzeSingleSweep
    'BUFFER_SEC', 0.1, ... % sec
    'TRANSIENT_END_BUFFER_SEC', 0.06 ... % sec
);

%%
data_directory = readtable(DATA_DIRECTORY_FILEPATH, 'Sheet', SHEET_TO_READ);


for trial_number = 1 : height(data_directory)
     try
        current_trial_directory_row = data_directory(trial_number, :);
        
        % Read sweeps from list 
        trial_folder_path = BuildRunFolderPath(current_trial_directory_row);
        SEARCH_STRING = 'protocol_Vclamp_rec';
        file_paths = FindFilepathsMatchingString(trial_folder_path, SEARCH_STRING);

        % Analyze each sweep 
        sweep_summaries = []; 
        for file_number = 1 : numel(file_paths)
            summary = AnalyzeSweeps(file_paths{file_number}, params);
            sweep_summaries = [sweep_summaries, summary]; 
        end
        
        current_trial_vclamp_params = ExtractVclampParamsFromSummariesList(sweep_summaries); 
        current_trial_cell_params = ReadCellParams(current_trial_directory_row); 

        WriteVclampParamsToFile(current_trial_directory_row, current_trial_vclamp_params)
        WriteCellParamsToFile(current_trial_directory_row, current_trial_cell_params)
        
        
     catch
        fprintf('Encountered an error processing trial %.0f, skipping to next.\n', ...
            trial_number); 
        fprintf('    Sweep ID: %.0f\n', data_directory{trial_number, 'sweep_id'});
        fprintf('    Cell name: %s\n', data_directory{trial_number, 'cell_name'}{1});
        fprintf('    Sweep name: %s\n', data_directory{trial_number, 'trial_name'}{1});
     end
end


% Plot results of each sweep
        
        


        


% end