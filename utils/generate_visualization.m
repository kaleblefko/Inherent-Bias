function [] = generate_visualization(C1, C2, net, num_hidden_layers, input_data_dim)
    [idx1C1, idx2C1] = get_random_pair_indices(C1);
    [idx1C2, idx2C2] = get_random_pair_indices(C2);
    idxs = [idx1C1, idx2C1, idx1C2, idx2C2];
    
    figure(1);
    hold on
    Y = [C1 C2];
    X = Y;
    y = [ones(1,size(C1,2))*1 ones(1,size(C2,2))*-1];
    if input_data_dim > 2
        Y = tsne(Y')';
    end
    plot_data(Y(:, y==1), Y(:, y==-1), 2);
    equalize_axes();
    ratio = plot_pairs(Y(:, y==1), Y(:, y==-1), C1, C2, idxs);
    annotation('textbox',...
    [0.700999999999999 0.309523809523813 0.240071428571429 0.06666666666667],...
    'String',sprintf('Pair Distance Ratio = %.2f', ratio),...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);
    hold off

    disp('Analyzing input data...');
    [h_ttest, p_ttest, p_ranksum, h_ranksum] = compare_distributions(X,y)
        
    analyze_network(net, X, y, num_hidden_layers, true, true, idxs);
end

