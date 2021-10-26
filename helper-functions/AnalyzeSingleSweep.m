 function current_sweep_summary = AnalyzeSingleSweep(current_sweep, params) 
%   function current_sweep_summary = AnalyzeSingleSweep() % for debugging 
    
 MAKE_DEBUG_PLOTS = true;
 
 % load in manually for debugging
%  debug_fn = 'D:\data\patching\10-14-2021\2021-10-14_09-23-27 _manual\sweep_4_1.0V\protocol_Vclamp_rec_92800AM.lvm';
%  tmp_sweeps = ReadSweepsFromFile(debug_fn);
%  current_sweep = tmp_sweeps(3); 
 
 % TEMPORARILY HARD-CODING PARAMS
% params = struct(...
%     'MOVING_AVERAGE_WINDOW_SEC', 0.05, ... % sec
%     'THRESHOLD_CURRENT_STEP',  15, ... % assume this is positive
%     'BUFFER_SEC', 0.1, ... % sec
%     'TRANSIENT_END_BUFFER_SEC', 0.06 ... % sec
% );
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  [y_lowpass, baseline] = ApplyMovingAverageFilter(current_sweep, params.MOVING_AVERAGE_WINDOW_SEC);
% current_step_threshold = abs(params.THRESHOLD_CURRENT_STEP); % approach 1
current_step_threshold = 0.08*(max(y_lowpass)-min(y_lowpass)); % approach 2, relative to step size


  


    indices_above_threshold = find(y_lowpass > baseline - current_step_threshold);
    [~, tmp_idx] = max(diff(indices_above_threshold));
    peak_start_index = indices_above_threshold(tmp_idx) - round(params.BUFFER_SEC/current_sweep.dt);
    peak_end_index = indices_above_threshold(tmp_idx + 1) + round(params.BUFFER_SEC/current_sweep.dt);
    peak_start_time = peak_start_index*current_sweep.dt;
    peak_end_time = peak_end_index*current_sweep.dt; 

    if MAKE_DEBUG_PLOTS
    figure
%     subplot(2, 1, 1)

    plot(current_sweep.t, current_sweep.y, '.', 'Color', 0.65*[1 1 1]);
    hold on
    plot(get(gca, 'XLim'), [0 0], 'k');
    plot(get(gca, 'XLim'), baseline*[1 1], 'k--');
    plot(current_sweep.t, y_lowpass, 'b');
    plot(get(gca, 'XLim'), [1 1]*(baseline - current_step_threshold), 'b--');
%         plot(peak_start_time*[1 1], get(gca, 'YLim'), 'b--');
%     plot(peak_end_time*[1 1], get(gca, 'YLim'), 'b--');

    tmp_indices_below_threshold = 1:length(current_sweep.t);
    tmp_mask = ismember(tmp_indices_below_threshold, indices_above_threshold);
    tmp_indices_below_threshold(tmp_mask) = [];
    indices_below_threshold = tmp_indices_below_threshold; 

    plot(current_sweep.t(indices_below_threshold), ...
        y_lowpass(indices_below_threshold), 'r.');
     title(sprintf('rep %.0f, %s, %s, %s', current_sweep.replicate_number, ...
        current_sweep.cell_name, current_sweep.trial_name, current_sweep.run_name), 'Interpreter', 'none');
    
 
end
    

    if peak_start_index <= 0
        error('negative peak start index, check fit parameters');
    elseif peak_end_index > length(current_sweep.t)
        error('peak end index exceeds signal length, check fit parameters');
    end
    
    peak_time_vector = current_sweep.t(peak_start_index:peak_end_index);
    peak_signal = current_sweep.y(peak_start_index:peak_end_index);
    peak_lowpass = y_lowpass(peak_start_index:peak_end_index);

    [most_negative_current, most_negative_current_peak_index] = min(peak_lowpass);
    most_negative_current = most_negative_current - baseline;
    most_negative_current_time = peak_start_time + most_negative_current_peak_index*current_sweep.dt; 

        if MAKE_DEBUG_PLOTS
       plot(most_negative_current_time, baseline+most_negative_current, 'b.', 'MarkerSize', 15)
   
        end
    
    s = tf('s');
    derivative = lsim(s/(0.01*s+1), y_lowpass-baseline, current_sweep.t);
    derivative_threshold = 0.15*(max(derivative)-min(derivative));

    

    
    %
    % figure
    % plot(derivative)
    % hold on
    % plot(get(gca, 'XLim'), derivative_threshold*[1 1], 'r--');



    [pks, locs] = findpeaks(derivative, ...
        'MinPeakHeight', derivative_threshold, ...
        'MinPeakWidth', 500);
    [~, biggest_peak_idx] = max(pks);

%     transient_end_idx = locs(biggest_peak_idx);
%     transient_end_time = transient_end_idx*current_sweep.dt - params.TRANSIENT_END_BUFFER_SEC; 
%     steady_state_photocurrent = -baseline + peak_lowpass(transient_end_idx - peak_start_index - round(params.TRANSIENT_END_BUFFER_SEC/current_sweep.dt));
%     steady_state_photocurrent_time = transient_end_time; 

    
% if MAKE_DEBUG_PLOTS
%     subplot(2, 1, 2)
%     
%     
%     
%     
%     
% end
%     
    current_sweep_summary = struct(...
        'fn', current_sweep.fn, ...
        'date', current_sweep.date, ...
        'cell_name', current_sweep.cell_name, ...
        'run_name', current_sweep.run_name, ...
        'trial_name', current_sweep.trial_name, ...
        'dt', current_sweep.dt, ...
        't', current_sweep.t, ...
        'y', current_sweep.y, ...
        'y_lowpass', y_lowpass, ...
        'peak_t', peak_time_vector, ...
        'peak_y', peak_signal, ...
        'peak_lowpass', peak_lowpass, ...
        'baseline', baseline, ...
        'peak_photocurrent', most_negative_current, ...
        'peak_photocurrent_time', most_negative_current_time, ...
        'peak_start_time', peak_start_time, ...
        'peak_end_time', peak_end_time ...
    );
%         'steady_state_photocurrent', steady_state_photocurrent, ...
%         'steady_state_photocurrent_time', steady_state_photocurrent_time, ...
%         'transient_end_time', transient_end_time ...
    end