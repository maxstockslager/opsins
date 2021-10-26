function [y_lowpass, baseline] = ApplyMovingAverageFilter(sweep, moving_average_window_sec)
dt = max(sweep.t) / (length(sweep.t) - 1);
moving_average_window = round(moving_average_window_sec/dt); % just for peak detection

baseline = quantile(sweep.y, 0.50); 
y_baseline_subtracted = sweep.y - baseline; 


filter_weights = [(1/moving_average_window)/2; ...
                  repmat((1/moving_average_window), moving_average_window-1, 1); 
                  (1/moving_average_window)/2];
y_lowpass = baseline + conv(y_baseline_subtracted, filter_weights, 'same');
end