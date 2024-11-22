function f=plot_latent_space(Y, y, plot_num)
    f = figure(plot_num);
    gscatter(Y(:,1), Y(:,2), y, 'br', '..', 10);
    title('t-SNE Visualization of Latent Space');
    xlabel('t-SNE Dimension 1');
    ylabel('t-SNE Dimension 2');
    legend('Location','southeastoutside');
    grid on;
end