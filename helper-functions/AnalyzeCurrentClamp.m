function summary = AnalyzeCurrentClamp(sweep, params)

[y_lowpass, baseline] = ApplyMovingAverageFilter(sweep, params.MOVING_AVERAGE_WINDOW_SEC);


summary = struct(...
    'fn', sweep.fn, ...
    'date', sweep.date, ...
    'cell_name', sweep.cell_name, ...
    'run_name', sweep.run_name, ...
    'trial_name', sweep.trial_name, ...
    'sweep_name', sweep.sweep_name, ...
    'dt', sweep.dt, ...
    't', sweep.t, ...
    'y', sweep.y, ...
    'y_lowpass', y_lowpass ...
);

