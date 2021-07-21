function data = ReadMultipleSweepsFromFilePathsList(file_paths)

    data = ReadSweepFromFile(file_paths{1});

    if numel(file_paths) > 1
        for ii = 2:numel(file_paths)
            data(ii) = ReadSweepFromFile(file_paths{ii});
        end
    end
end