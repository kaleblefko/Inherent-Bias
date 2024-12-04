function f=plot_latent_space(Y, y, plot_num, layer_num, data)
    f = figure(plot_num);

    gscatter(Y(:,1), Y(:,2), y, 'br', '..', 10);
    if plot_num == 1
        title('t-SNE Visualization of Input Space');
    elseif plot_num ~= 1
        title(sprintf('t-SNE Visualization of Latent Space of Hidden Layer %d', layer_num));
    end
    xlabel('t-SNE Dimension 1');
    ylabel('t-SNE Dimension 2');
    legend({'C2', 'C1'}, 'Location','southeastoutside');
    [h_ttest, p_ttest, p_ranksum, h_ranksum] = compare_distributions(data,y);
    annotation(f, 'textbox',...
                [0.700999999999999 0.409523809523813 0.240071428571429 0.06666666666667],...
                'String',sprintf('ttest2 p = %.2e\nranksum p = %.2e', p_ttest, p_ranksum),...
                'FitBoxToText','off',...
                'BackgroundColor',[1 1 1]);
    grid on;
end