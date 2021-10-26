function PlotSweepSummary(summary)
subplot(2, 1, 1)
plot(summary.t, summary.y, 'k.', 'MarkerSize', 0.5, 'Color', 0.25*[1 1 1])
hold on
plot(summary.t, summary.y_lowpass, 'r', 'LineWidth', 2)
set(gcf, 'Color', 'white');
title(BuildPlotTitle(summary), 'Interpreter', 'none')
xlabel('Time (s)');
ylabel('Current (pA)');
plot([0, max(summary.t)], summary.baseline*[1 1], 'b--');
% plot([0, max(summary.t)], summary.peak_photocurrent*[1 1], 'b--');
plot(summary.peak_photocurrent_time, summary.baseline + summary.peak_photocurrent, 'g.', 'MarkerSize', 15);
plot(summary.steady_state_photocurrent_time, summary.baseline + summary.steady_state_photocurrent, 'g.', 'MarkerSize', 15);
% plot(summary.peak_start_time*[1 1], get(gca, 'YLim'), 'k--');
% plot(summary.transient_end_time*[1 1], get(gca, 'YLim'), 'k--');
% plot(summary.peak_end_time*[1 1], get(gca, 'YLim'), 'k--');

subplot(2, 1, 2)
plot(summary.peak_t, summary.peak_y, 'k.', 'MarkerSize', 0.5, 'Color', 0.25*[1 1 1])
hold on
plot(summary.peak_t, summary.peak_lowpass, 'r', 'LineWidth', 2)
set(gcf, 'Color', 'white');
title(BuildPlotTitle(summary), 'Interpreter', 'none')
xlabel('Time (s)');
ylabel('Current (pA)');
plot([min(summary.peak_t), max(summary.peak_t)], summary.baseline*[1 1], 'b--');
% plot([min(summary.peak_t), max(summary.peak_t)], summary.peak_photocurrent*[1 1], 'b--');
% plot(summary.peak_start_time*[1 1], get(gca, 'YLim'), 'k--');
% plot(summary.transient_end_time*[1 1], get(gca, 'YLim'), 'k--');
% plot(summary.peak_end_time*[1 1], get(gca, 'YLim'), 'k--');
set(gca, 'XLim', [summary.peak_start_time, summary.peak_end_time])
plot(summary.peak_photocurrent_time, summary.baseline + summary.peak_photocurrent, 'g.', 'MarkerSize', 15);
plot(summary.steady_state_photocurrent_time, summary.baseline + summary.steady_state_photocurrent, 'g.', 'MarkerSize', 15);
end