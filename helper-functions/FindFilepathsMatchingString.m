    function file_paths = FindFilepathsMatchingString(directory, SEARCH_STRING)
        filenames = FindFilesMatchingString(directory, SEARCH_STRING);
        file_paths = arrayfun(@(fn) fullfile(directory, fn), filenames);
    end