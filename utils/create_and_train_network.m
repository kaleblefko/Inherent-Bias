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