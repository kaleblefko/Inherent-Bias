function [] = generate_visualization(C1, C2, net, num_hidden_layers, input_data_dim)
    [idx1C1, idx2C1] = get_random_pair_indices(C1);
    [idx1C2, idx2C2] = get_random_pair_indices(C2);
    idxs = [idx1C1, idx2C1, idx1C2, idx2C2];

    hold on
    Y = [C1 C2];
    X = Y;
    y = [ones(1,size(C1,2))*1 ones(1,size(C2,2))*-1];
    if input_data_dim > 2
        Y = tsne(Y')';
    end
    plot_data(Y(:, y==1), Y(:, y==-1), 2);
    equalize_axes();
    plot_pairs(Y(:, y==1), Y(:, y==-1), idxs);
    hold off
        
    analyze_network(net, X, y, num_hidden_layers, true, true, idxs);
end

