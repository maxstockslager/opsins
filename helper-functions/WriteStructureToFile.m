function WriteStructureToFile(structure, filename)
fid = fopen(filename, 'w');
field_names = fieldnames(structure);
for field_number = 1 : numel(field_names)
current_field_name = field_names{field_number};
new_line_value_raw = structure.(current_field_name);

if (isnumeric(new_line_value_raw) && length(new_line_value_raw) > 1)
    new_line_value_string = sprintf('%.3f,' , new_line_value_raw);
    new_line_value_string = new_line_value_string(1:end-1);% strip final comma
elseif isnumeric(new_line_value_raw)
    new_line_value_string = num2str(new_line_value_raw);
else
    new_line_value_string = new_line_value_raw;
end

new_line = [current_field_name, ',', new_line_value_string];
fprintf(fid, '%s', new_line); 
fprintf(fid, '\n');

end
end