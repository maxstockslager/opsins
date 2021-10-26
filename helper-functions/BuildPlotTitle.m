    function plot_title = BuildPlotTitle(summary)
        plot_title = ['Date: ', summary.date, ...
                    '. Cell: ', summary.cell_name, ...
                    '. Trial: ', summary.trial_name];
    end

%  '. Sweep: ', num2str(summary.sweep_name)];