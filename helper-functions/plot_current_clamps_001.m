clear all, close all
addpath('helper-functions');

DIRECTORY = 'D:\data\patching\5-27-2021';

VCLAMP_ANALYSIS_PARAMS = struct(...
    'MOVING_AVERAGE_WINDOW_SEC', 0.001, ... % sec
    'THRESHOLD_CURRENT_STEP',  25, ... % assume this is positive
    'BUFFER_SEC', 0.001, ... % sec
    'TRANSIENT_END_BUFFER_SEC', 0.001 ... % sec
);

% trial_folder_path = BuildRunFolderPath(data_directory_row);
trial_folder_path = 'D:\data\patching\5-27-2021\0_m1_1 12 PM\t1';

SEARCH_STRING = 'protocol_Iclamp_rec';
file_paths = FindFilepathsMatchingString(trial_folder_path, SEARCH_STRING);
data = ReadSweepsFromFilePathsList(file_paths);

sweep_summaries = []; 
for sweep_number = 1 : numel(data)
    summary = AnalyzeCurrentClamp(data(sweep_number), VCLAMP_ANALYSIS_PARAMS);
    figure
    PlotCurrentClamp(summary)

    sweep_summaries = [sweep_summaries, summary]; 
end