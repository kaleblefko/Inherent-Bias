% [C1, C2]=produce_single_mode_set(2, [1,4], [2,6], [1, 4], [1, 4], true, [800, 800], [800, 800]);
close all; clear all; clc
N_modes = 1;
l = 2;
mean_c1 = [1, 100];
mean_c2 = [100, 100];
cov_c1 = [30, 30];
cov_c2 = [30, 30];
diag_cov = false;
N1 = [800, 800];
N2 = [800, 800];
even_spread = true;

[C1, C2]=produce_single_mode_set(l, mean_c1, mean_c2, cov_c1, cov_c2, diag_cov, N1, N2);

plot_data(C1, C2, 2);

X = [C1 C2];
y = [ones(1,size(C1,2))*1 ones(1,size(C2,2))*-1];
number_hidden_layers = 3;
max_neurons = 10;
train_fnc = 'traingd';

net = create_and_train_network(number_hidden_layers, max_neurons, l, train_fnc, X, y);
disp('Analyzing input data...');
[h_ttest, p_ttest, p_ranksum, h_ranksum] = compare_distributions(X,y)
analyze_network(net, X, y, number_hidden_layers);

save('C1.mat', 'C1');
save('C2.mat', 'C2'); 
save('net.mat', 'net');

function [C1, C2]=produce_single_mode_set(l, m_minmax_c1, m_minmax_c2, cov_minmax_c1, cov_minmax_c2, diag_cov, N1_minmax, N2_minmax)
    m_sz = [l 1];
    cov_sz = [l l];

    N1 = randi([N1_minmax(1) N1_minmax(2)],1);
    N2 = randi([N2_minmax(1) N2_minmax(2)],1);

    [m1, cov1] = produce_m_and_cov(m_sz, m_minmax_c1, cov_sz, cov_minmax_c1, true, 1);
    [m2, cov2] = produce_m_and_cov(m_sz, m_minmax_c2, cov_sz, cov_minmax_c2, true, 1);

    C1 = mvnrnd(m1, cov1, N1)';
    C2 = mvnrnd(m2, cov2, N2)';
end

function [C1, C2]=produce_n_mode_set(N_mode, l, m_minmax_c1, m_minmax_c2, cov_minmax_c1, cov_minmax_c2, diag_cov, N1_minmax, N2_minmax, even_mode_spread)
    N1 = randi([N1_minmax(1) N1_minmax(2)],1);
    N2 = randi([N2_minmax(1) N2_minmax(2)],1);

    m_sz = [l 1];
    cov_sz = [l l];
   
    N1_per_mode = [];
    N2_per_mode = [];

    C1 = [];
    C2 = [];

    for i=1:N_mode
        if even_mode_spread
            N1_per_mode = [N1_per_mode, floor(N1/N_mode)];
            N2_per_mode = [N2_per_mode, floor(N1/N_mode)];
        end
        if i==N_mode
            N1_per_mode(i) = N1_per_mode(i) + mod(N1,N_mode);
            N2_per_mode(i) = N2_per_mode(i) + mod(N2,N_mode);
        end
    end
    
    for i=1:length(N1_per_mode)
        [m1, cov1] = produce_m_and_cov(m_sz, m_minmax_c1, cov_sz, cov_minmax_c1, true, 1);
        C1 = [C1; mvnrnd(m1, cov1, N1_per_mode(i))];
    end

    for i=1:length(N2_per_mode)
        [m2, cov2] = produce_m_and_cov(m_sz, m_minmax_c2, cov_sz, cov_minmax_c2, true, 1);
        C2 = [C2; mvnrnd(m2, cov2, N2_per_mode(i))];
    end
    C1=C1';
    C2=C2';
end

function [m, cov]=produce_m_and_cov(m_sz, m_minmax, cov_sz, cov_minmax, diag_cov, mode)
    m = unifrnd(m_minmax(1), m_minmax(2), m_sz);
    cov = unifrnd(cov_minmax(1), cov_minmax(2), cov_sz);
    if diag_cov
        mask = eye(size(cov));
        cov = cov .* mask;
    end
end

function plot_data(C1, C2, dimensions)
    figure(1);
    if dimensions==2
        scatter(C1(1,:), C1(2,:), MarkerEdgeColor="red")
        hold on
        scatter(C2(1,:), C2(2,:), MarkerEdgeColor="blue")
        xlabel("x1")
        ylabel("x2")
    else
        embedded_C1 = run_umap(C1')';
        embedded_C2 = run_umap(C2')';
        scatter(embedded_C1(1,:), embedded_C1(2,:), MarkerEdgeColor="cyan")
        hold on
        scatter(embedded_C2(1,:), embedded_C2(2,:), MarkerEdgeColor="green")
        xlabel("embedded x1")
        ylabel("embedded x2")
    end
end

function [net]=create_and_train_network(num_hidden_layers, max_neurons, l, train_fnc, X, y)
    layers = zeros(1,num_hidden_layers);
    layers(1)=int8(unifrnd(l, max_neurons));
    for i=2:num_hidden_layers
        layers(i)=int8(unifrnd(l, layers(i-1)));
    end
    net = feedforwardnet(layers, train_fnc);
    for i=1:num_hidden_layers
        net.layers{i}.transferFcn = 'logsig';
    end
    net = train(net, X, y);
end

function [h_ttest, p_ttest, p_ranksum, h_ranksum]=compare_distributions(hidden_layer_outputs, y)
    latent_dist0 = pdist(hidden_layer_outputs(:,(y==1))');
    latent_dist1 = pdist(hidden_layer_outputs(:,(y==-1))');
    [h_ttest,p_ttest] = ttest2(latent_dist0, latent_dist1);
    [p_ranksum, h_ranksum] = ranksum(latent_dist0, latent_dist1);
end

function []=plot_latent_space(Y, y, plot_num)
    f = figure(plot_num);
    gscatter(Y(:,1), Y(:,2), y, 'br', '..', 10);
    title('t-SNE Visualization of Latent Space');
    xlabel('t-SNE Dimension 1');
    ylabel('t-SNE Dimension 2');
    legend('Location','southeastoutside');
    grid on;
end

function [Y, hidden_layer_outputs]=obtain_latent_space_representation(net, input_to_layer, layer_num)
    if layer_num == 1
        W = net.IW{layer_num};
        b = net.b{layer_num};
    else
        W = net.LW{layer_num, layer_num-1};
        b = net.b{layer_num};
    end
    hidden_layer_outputs = W * input_to_layer + b; % Get sigmoid activations
    Y = tsne(hidden_layer_outputs');
end

function []=analyze_network(net, X, y, num_hidden_layers)
    for i=1:num_hidden_layers
        fprintf("Analyzing layer %d...\n", i);
        if i == 1
            [Y, hidden_layer_outputs] = obtain_latent_space_representation(net, X, i);
            [h_ttest, p_ttest, p_ranksum, h_ranksum] = compare_distributions(hidden_layer_outputs, y)
        else
            [Y, hidden_layer_outputs] = obtain_latent_space_representation(net, hidden_layer_outputs, i);
            [h_ttest, p_ttest, p_ranksum, h_ranksum] = compare_distributions(hidden_layer_outputs, y)
        end
        plot_latent_space(Y, y, i+1);
        file_name = sprintf('Y%d.mat', i);
        save(file_name, 'Y');
    end
end