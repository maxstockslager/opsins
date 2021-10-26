    function file_paths = FindFolderPathsMatchingString(directory, SEARCH_STRING)
        filenames = FindFoldersMatchingString(directory, SEARCH_STRING);
        file_paths = arrayfun(@(fn) fullfile(directory, fn), filenames);
    end