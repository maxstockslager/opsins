clear all, close all

base_directory = 'D:\data\patching\';
% expt_folder = '6-3-2021\2_m1_3 42 PM\t1\';
expt_folder = '7-9-2021\0_m1_11 39 AM\t1\';
% directory = fullfile(base_directory, expt_folder);
fn = 'protocol_Vclamp_rec_114242AM.lvm';

full_file_path = fullfile(base_directory, expt_folder, fn);
data = lvm_import(full_file_path, false)

clf
figure(1)
% plot(data.Segment1.data(:, 1), data.Segment1.data(:, 2), 'k');
% set(gcf, 'Color', 'white')
% xlabel('Time (s)');
% ylabel('Current (pA)');
% hold on

tau = 0.01; % sec
s = tf('s');
G = 1/(tau*s+1);

tt = data.Segment1.data(:, 1);
yy = data.Segment1.data(:, 2);
y_filt = lsim(G, yy, tt);

figure(1)

plot(tt, yy, 'k.', 'MarkerSize', 0.5, 'Color', 0.25*[1 1 1])
hold on
plot(tt, y_filt, 'r', 'LineWidth', 2)
set(gca, 'YLim', [-1800 -400])
set(gca, 'XLim', [4.5 8.5])
set(gcf, 'Color', 'white');
xlabel('Time (s)');
ylabel('Current (pA)');
set(gcf, 'Position', [680   661   575   317])

%%
% start_time = 5;
% end_time = 8; 
% 
% 
% 
% dt = data.Segment1.data(2,1) - data.Segment1.data(1,1);
% tt = transpose(start_time:dt:(end_time-dt));
% start_ind = start_time/dt;
% end_ind = end_time/dt - 1; 
% 
% tt = tt - tt(1);
% yy = data.Segment1.data(start_ind : end_ind, 2);
% yy_filt = y_filt(start_ind : end_ind);
% 
% figure(2)
% plot(tt, yy, '.', 'Color', 0.75*[1 1 1]);
% hold on
% plot(tt, yy_filt, 'b', 'LineWidth', 3)
% plot([1 1], get(gca, 'YLim'), 'k--');
% plot([2 2], get(gca, 'YLim'), 'k--');
% set(gcf, 'Color', 'white');
% xlabel('Time (s)');
% ylabel('Current (pA)');
% set(gcf, 'Position', [-1698 621 478 278])