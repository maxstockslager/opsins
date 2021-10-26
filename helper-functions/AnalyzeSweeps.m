function summary = AnalyzeSweeps(filename, params) %params)

% filename = 'D:\data\patching\10-14-2021\2021-10-14_09-23-27 _manual\sweep_1_4.0V\protocol_Vclamp_rec_92521AM.lvm';

% TEMPORARILY HARD-CODING PARAMS
% params = struct(...
%     'MOVING_AVERAGE_WINDOW_SEC', 0.05, ... % sec
%     'THRESHOLD_CURRENT_STEP',  15, ... % assume this is positive
%     'BUFFER_SEC', 0.1, ... % sec
%     'TRANSIENT_END_BUFFER_SEC', 0.06 ... % sec
% );

% need to do this at beginning to determine number of files
sweeps = ReadSweepsFromFile(filename);


summary = struct();
for replicate_number = 1 : numel(sweeps)
    current_sweep_summary = AnalyzeSingleSweep(sweeps(replicate_number), params);
        
    if replicate_number == 1
        summary = current_sweep_summary;
    else
        summary = [summary, current_sweep_summary];
    end
end

end