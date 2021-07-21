function data = ReadSweepFromFile(varargin)

addpath('helper-functions')
% inputs:
% varargin{1}: file path (else prompts to pick file)

if numel(varargin) > 0
    filename = varargin{1};
else
%     full_file_path = uigetfile('D:\data\patching\');
    filename = 'D:\data\patching\7-9-2021\0_m1_11 39 AM\t1\protocol_Vclamp_rec_114242AM.lvm';
end
    
metadata = ExtractMetadataFromFilename(filename); 

raw = lvm_import(filename, false);
data = struct(...
    'fn', filename, ...
    'date', metadata.date, ...
    'cell_name', metadata.cell_name, ...
    'trial_name', metadata.trial_name, ...
    'sweep_name', metadata.sweep_name, ...
    't', raw.Segment1.data(:,1), ...
    'y', raw.Segment1.data(:, 2), ...
    'dt', max(raw.Segment1.data(:,1)) / (length(raw.Segment1.data(:,1)) - 1) ...
 );
end
% 
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
