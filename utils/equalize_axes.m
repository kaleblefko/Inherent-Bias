function equalize_axes()
    ax = gca;
    x_limits = ax.XLim;
    y_limits = ax.YLim;

    max_range = max([diff(x_limits), diff(y_limits)]);

    x_center = mean(x_limits);
    y_center = mean(y_limits);

    ax.XLim = x_center + [-1, 1] * max_range / 2;
    ax.YLim = y_center + [-1, 1] * max_range / 2;
    axis equal;
end
