function fns_containing_search_string = FindFilesMatchingString(folder, search_string)

files_list = dir(folder);
file_names = {files_list.name};

check_for_search_string = @(fn) contains(fn, search_string);
do_fns_contain_search_string = arrayfun(check_for_search_string, file_names);
fns_containing_search_string = file_names(do_fns_contain_search_string);
end