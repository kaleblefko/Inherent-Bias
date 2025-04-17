addpath("./utils");
rng(0,'twister');
close all;clear all;clc

load("data/perfect/C1.mat", "C1");
load("data/perfect/C2.mat", "C2");
X = [C1 C2];
y = [ones(1,size(C1,2))*1 ones(1,size(C2,2))*-1];
bias_counter = 0;
n = 10000;
max_neurons = 500;
layer_count_range = [2, 10];
dim = 3;
train_fnc = 'traingd';

for i = 1:n

    number_hidden_layers = randi(layer_count_range);
    net = create_and_train_network(number_hidden_layers, max_neurons, dim, train_fnc, X, y);
    [possible_bias, results] = analyze_network(net, X, y, number_hidden_layers, false);

    if possible_bias
        bias_counter = bias_counter + 1;
        fprintf("%d / %d\n", bias_counter, i);
        disp(results);
    end

end

