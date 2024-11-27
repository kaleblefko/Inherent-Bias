function f=plot_latent_space(Y, y, plot_num)
    f = figure(plot_num);

    gscatter(Y(:,1), Y(:,2), y, 'br', '..', 10);
    if plot_num == 1
        title('t-SNE Visualization of Input Space');
    elseif plot_num ~= 1
        title(sprintf('t-SNE Visualization of Latent Space of Hidden Layer %d', plot_num-1));
    end
    xlabel('t-SNE Dimension 1');
    ylabel('t-SNE Dimension 2');
    legend({'C2', 'C1'}, 'Location','southeastoutside');
    grid on;
end