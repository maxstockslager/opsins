clear all, close all
addpath('helper-functions')

DIRECTORY = 'D:\data\patch-data-directory.xlsx';
raw = readtable(DIRECTORY)


row_number = 1; 
entry = ExtractDataFromTable(raw, row_number, col)


%%
% get filenames that contain "protocol_Vclamp" (can do others later)
trial_folder = 'D:\data\patching\7-9-2021\0_m1_11 39 AM\t1\';
SEARCH_STRING = 'protocol_Vclamp_rec';
filenames = FindFilesMatchingString(trial_folder, SEARCH_STRING);
file_paths = arrayfun(@(fn) fullfile(trial_folder, fn), filenames);

%% load in all data from files (then process individually in next step)
data = ReadMultipleSweepsFromFilePathsList(file_paths);

%% process one sweep
PARAMS = struct(...
    'MOVING_AVERAGE_WINDOW_SEC', 0.03, ... % sec
    'THRESHOLD_CURRENT_STEP',  25, ... % assume this is positive
    'BUFFER_SEC', 0.05, ... % sec
    'TRANSIENT_END_BUFFER_SEC', 0.06 ... % sec
);

for sweep_number = 1 : numel(data)
    summary = AnalyzeSweep(data(sweep_number), PARAMS);
    WriteSummaryToFile(summary)
    figure
    PlotSweepSummary(summary)
end

% save figure to file also -- pdf? svg?  0