function [possible_bias]=analyze_network(net, X, y, num_hidden_layers, plot_latent, plot_pair, idxs)
    possible_bias = false;
    for i=1:num_hidden_layers

        fprintf("Analyzing layer %d...\n", i);
        if i == 1
            [Y, hidden_layer_outputs] = obtain_latent_space_representation(net, X, i);
            [h_ttest, p_ttest, p_ranksum, h_ranksum] = compare_distributions(hidden_layer_outputs, y)
        else
            [Y, hidden_layer_outputs] = obtain_latent_space_representation(net, hidden_layer_outputs, i);
            [h_ttest, p_ttest, p_ranksum, h_ranksum] = compare_distributions(hidden_layer_outputs, y)
        end
        if (h_ttest || h_ranksum)
            possible_bias = true;
        end

        if plot_latent && (size(Y, 2) >= 2)
            plot_latent_space(Y, y, i+1);
            equalize_axes();
            if plot_pair
                hold on
                Y = Y';
                ratio = plot_pairs(Y(:,y==1),Y(:,y==-1), ...
                    hidden_layer_outputs(:, y==1), ...
                    hidden_layer_outputs(:, y==-1), idxs);
                annotation('textbox',...
                    [0.700999999999999 0.309523809523813 0.240071428571429 0.06666666666667],...
                    'String',sprintf('Pair Distance Ratio = %.2f', ratio),...
                    'FitBoxToText','off',...
                    'BackgroundColor',[1 1 1]);
                hold off 
            end
        end

    end
    
end