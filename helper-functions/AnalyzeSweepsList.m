    function sweep_summaries = AnalyzeSweepsList(file_paths, PARAMS);
    sweep_summaries = []; 
    for file_number = 1 : numel(file_paths)
        summary = AnalyzeSweeps(file_paths{file_number}, PARAMS);
        sweep_summaries = [sweep_summaries, summary]; 
    end
    end