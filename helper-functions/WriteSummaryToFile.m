function WriteSummaryToFile(summary)
output = rmfield(summary, {'t', 'y', 'y_lowpass', 'peak_t', 'peak_y', 'peak_lowpass'});
data_save_directory = fullfile('D:\data\patching\', ...
                                output.date, ...
                                output.cell_name, ...
                                output.trial_name);
data_save_filename = fullfile(data_save_directory, 'summary.csv');
output_table = struct2table(output);
writetable(struct2table(output), data_save_filename);
end