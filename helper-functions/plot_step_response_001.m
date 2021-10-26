clear all, close all
addpath('helper-functions')

DATA_DIRECTORY_FILEPATH = 'D:\data\patch-data-directory.xlsx';

VCLAMP_ANALYSIS_PARAMS = struct(...
    'MOVING_AVERAGE_WINDOW_SEC', 0.03, ... % sec
    'THRESHOLD_CURRENT_STEP',  25, ... % assume this is positive
    'BUFFER_SEC', 0.05, ... % sec
    'TRANSIENT_END_BUFFER_SEC', 0.06 ... % sec
);

%%
data_directory = readtable(DATA_DIRECTORY_FILEPATH);

for trial_number = 1 : height(data_directory)
    current_trial_directory_row = data_directory(trial_number, :);
    current_trial_vclamp_summaries = AnalyzeVoltageClamps(current_trial_directory_row, VCLAMP_ANALYSIS_PARAMS);
    current_trial_vclamp_params = ExtractVclampParamsFromSummariesList(current_trial_vclamp_summaries); 
    current_trial_cell_params = ReadCellParams(current_trial_directory_row); 
      

    figure
    summary = current_trial_vclamp_summaries(1); 
    plot(summary.t(1:10:end), summary.y(1:10:end), 'k.', 'MarkerSize', 0.5, 'Color', 0.25*[1 1 1])
    hold on
    plot(summary.t(1:10:end), summary.y_lowpass(1:10:end), 'r', 'LineWidth', 2)
    set(gcf, 'Color', 'white');
    title(BuildPlotTitle(summary), 'Interpreter', 'none')
    xlabel('Time (s)');
    ylabel('Current (pA)');
    plot([0, max(summary.t)], summary.baseline*[1 1], 'b--');
    % plot([0, max(summary.t)], summary.peak_photocurrent*[1 1], 'b--');
%     plot(summary.peak_photocurrent_time, summary.baseline + summary.peak_photocurrent, 'g.', 'MarkerSize', 15);
%     plot(summary.steady_state_photocurrent_time, summary.baseline + summary.steady_state_photocurrent, 'g.', 'MarkerSize', 15);
    % plot(summary.peak_start_time*[1 1], get(gca, 'YLim'), 'k--');
    % plot(summary.transient_end_time*[1 1], get(gca, 'YLim'), 'k--');
    % plot(summary.peak_end_time*[1 1], get(gca, 'YLim'), 'k--');
    
    set(gca, 'XLim', [4 9]);
    set(gca, 'YLim', [-1800 -400])
    set(gcf, 'Position', [-1179         551         533         288]);
    
end