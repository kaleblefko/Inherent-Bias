function highlight_point(center, color, dim)
    if dim == 3
        scatter3(center(1), center(2), center(3), color, 'filled', 'HandleVisibility','off');
    else
        scatter(center(1), center(2), color, 'filled', 'HandleVisibility','off');
        plot_circle(center(1), center(2), 1, color, 2);
    end
end

