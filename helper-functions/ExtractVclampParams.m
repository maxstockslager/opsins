function vclamp_params = ExtractVclampParams(vclamp_summary)
vclamp_params = rmfield(vclamp_summary, ...
    {'t', 'y', 'y_lowpass', 'peak_t', 'peak_y', 'peak_lowpass'});
end