function metadata = ExtractMetadataFromFilename(filename)
last_slash_idx = find(filename == '\', 1, 'last');
last_period_idx = find(filename == '.', 1, 'last');
metadata.sweep_name = filename(last_slash_idx+1 : last_period_idx - 1);

last_two_slash_indices = find(filename == '\', 2, 'last');
metadata.trial_name = filename(last_two_slash_indices(1)+1 : last_two_slash_indices(2)-1);

last_four_slash_indices = find(filename == '\', 4, 'last');
metadata.cell_name = filename(last_four_slash_indices(2)+1 : last_four_slash_indices(3)-1);
metadata.date = filename(last_four_slash_indices(1)+1 : last_four_slash_indices(2)-1);

end
