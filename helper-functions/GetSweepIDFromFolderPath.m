function sweep_label = GetSweepIDFromFolderPath(filepath, DELIM)

for char_idx = (length(filepath):-1:1)
    if strcmp(filepath(char_idx), DELIM)
        last_delim_idx = char_idx;
        break
    end 
end

sweep_label = filepath((char_idx+1):end);

end