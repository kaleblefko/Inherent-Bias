function [Y, hidden_layer_outputs]=obtain_latent_space_representation(net, input_to_layer, layer_num)
    if layer_num == 1
        W = net.IW{layer_num};
        b = net.b{layer_num};
    else
        W = net.LW{layer_num, layer_num-1};
        b = net.b{layer_num};
    end
    hidden_layer_outputs = W * input_to_layer + b;
    Y = tsne(hidden_layer_outputs');
end