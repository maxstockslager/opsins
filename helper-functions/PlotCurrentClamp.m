function PlotCurrentClamp(summary)
subplot(2, 1, 1)
plot(summary.t, summary.y, 'k.', 'MarkerSize', 0.5, 'Color', 0.25*[1 1 1])
hold on
plot(summary.t, summary.y_lowpass, 'r', 'LineWidth', 2)
set(gcf, 'Color', 'white');
xlabel('Time (s)');
ylabel('Current (pA)');

end