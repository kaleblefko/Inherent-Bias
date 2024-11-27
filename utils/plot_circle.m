function h = plot_circle(x,y,r,color,thickness)
    th = 0:pi/50:2*pi;
    xunit = r * cos(th) + x;
    yunit = r * sin(th) + y;
    h = plot(xunit, yunit, color, 'LineWidth',thickness, 'HandleVisibility','off');
end