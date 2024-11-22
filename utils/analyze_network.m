function analyze_network(net, X, y, num_hidden_layers)
    for i=1:num_hidden_layers
        fprintf("Analyzing layer %d...\n", i);
        if i == 1
            [Y, hidden_layer_outputs] = obtain_latent_space_representation(net, X, i);
            [h_ttest, p_ttest, p_ranksum, h_ranksum] = compare_distributions(hidden_layer_outputs, y);
        else
            [Y, hidden_layer_outputs] = obtain_latent_space_representation(net, hidden_layer_outputs, i);
            [h_ttest, p_ttest, p_ranksum, h_ranksum] = compare_distributions(hidden_layer_outputs, y);
        end
        plot_latent_space(Y, y, i+1);
    end
end