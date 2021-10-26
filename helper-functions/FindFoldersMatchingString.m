function fns_containing_search_string = FindFoldersMatchingString(folder, search_string)

folders_list = dir(folder);

is_directory = [folders_list.isdir];
folders_list = folders_list(is_directory);

folder_names = {folders_list.name};

check_for_search_string = @(fn) contains(fn, search_string);
do_fns_contain_search_string = arrayfun(check_for_search_string, folder_names);
fns_containing_search_string = folder_names(do_fns_contain_search_string);
end