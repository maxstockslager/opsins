function output = ExtractVclampParamsFromSummariesList(vclamp_summaries) 
vclamp_params_list = []; 
for ii = 1 : numel(vclamp_summaries) 
    tmp = ExtractVclampParams(vclamp_summaries(ii));
    vclamp_params_list = [vclamp_params_list, tmp]; 
end

% convert the array of structures into a single structure (with 
% arrays for the elements that change)
field_names = fieldnames(vclamp_params_list); 

output = vclamp_params_list(1); % initialize
for field_number = 1 : numel(field_names)
    current_field_name = field_names{field_number};
    field_values = {vclamp_params_list.(current_field_name)};
    
    if length(field_values) == 1
        all_values_equal = true;
    else
        all_values_equal = true; % initialize
        for ii = 2:length(field_values)
           if field_values{ii} ~= field_values{1} 
               all_values_equal = false;
           end
        end
    end
    
    
    if all_values_equal
        output.(current_field_name) = field_values{1}; 
    else
        output.(current_field_name) = cell2mat(field_values);
    end

end