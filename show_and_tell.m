close all;
randn('seed', 0);
load('C1_2.mat', 'C1');
load('C2_2.mat', 'C2');
load('net2.mat', 'net');

N1 = [800, 800];
N2 = [800, 800];
X = [C1 C2];
y = [ones(1,size(C1,2))*1 ones(1,size(C2,2))*-1];
size(X)
plot_data(C1, C2, 2);
disp('Analyzing input data...');
[h_ttest, p_ttest, p_ranksum, h_ranksum] = compare_distributions(X,y)
analyze_network(net, X, y, 3);

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

function [h_ttest, p_ttest, p_ranksum, h_ranksum]=compare_distributions(hidden_layer_outputs, y)
    latent_dist0 = pdist(hidden_layer_outputs(:,(y==1)));
    latent_dist1 = pdist(hidden_layer_outputs(:,(y==-1)));
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
        % file_name = sprintf('Y%d.mat', i);
        % save(file_name, 'Y');
    end
end