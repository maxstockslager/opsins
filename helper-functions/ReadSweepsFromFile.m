function data = ReadSweepsFromFile(filename)

addpath('helper-functions')
% inputs:
% varargin{1}: file path (else prompts to pick file)

% if numel(varargin) > 0
%     filename = varargin{1};
% else
% %     full_file_path = uigetfile('D:\data\patching\');
%     filename = 'D:\data\patching\7-9-2021\0_m1_11 39 AM\t1\protocol_Vclamp_rec_114242AM.lvm';
% end
    
metadata = ExtractMetadataFromFilename(filename); 
raw = lvm_import(filename, false);

% figure out how many columns are in the data. i think the first is t
% and the rest are all different sweeps. check number of rows

[~, n_cols] = size(raw.Segment1.data);
n_sweeps = n_cols - 1; % first column is time, the rest are sweeps

data = [];
for replicate_number = 1 : n_sweeps    
    current_sweep_data = struct(...
        'fn', filename, ...
        'replicate_number', replicate_number, ...
        'date', metadata.date, ...
        'cell_name', metadata.cell_name, ...
        'run_name', metadata.run_name, ...
        'trial_name', metadata.trial_name, ...
        't', raw.Segment1.data(:,1), ...
        'y', raw.Segment1.data(:, 1+replicate_number), ...
        'dt', max(raw.Segment1.data(:,1)) / (length(raw.Segment1.data(:,1)) - 1) ...
     );
 
 
         %'sweep_name', sweep_number, ...
    data = [data, current_sweep_data];
end



% figure
% tau = 0.01; % sec
% s = tf('s');
% G = 1/(tau*s+1);
% 
% tt = data.Segment1.data(:, 1);
% yy = data.Segment1.data(:, 2);
% y_filt = lsim(G, yy, tt);
% 
% figure(1)
% 
% plot(tt, yy, 'k.', 'MarkerSize', 0.5, 'Color', 0.25*[1 1 1])
% hold on
% plot(tt, y_filt, 'r', 'LineWidth', 2)
% set(gca, 'YLim', [-1800 -400])
% set(gca, 'XLim', [4.5 8.5])
% set(gcf, 'Color', 'white');
% xlabel('Time (s)');
% ylabel('Current (pA)');
% set(gcf, 'Position', [680   661   575   317])
