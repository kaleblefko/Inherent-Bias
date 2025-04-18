function plot_pdist_histograms(c1_pdists,  c2_pdists, p_ttest, p_ranksum, plot_num, layer_num)
    figure(plot_num);
    hold on
    histogram(c1_pdists, 'DisplayName', 'C1');
    histogram(c2_pdists, 'DisplayName', 'C2');
    title(sprintf("Pairwise Distance Distributions for Layer %d", layer_num));
    if layer_num == 0
        title("Pairwise Distance Distributions for Input Data");
    else
        title(sprintf("Pairwise Distance Distributions for Layer %d", layer_num));
    end
    legend;
    annotation('textbox',...
                    [0.700999999999999 0.309523809523813 0.240071428571429 0.06666666666667],...
                    'String',sprintf('ttest2 p = %.2e\nranksum p = %.2e', p_ttest, p_ranksum),...
                    'FitBoxToText','off',...
                    'BackgroundColor',[1 1 1]);
    hold off
end
