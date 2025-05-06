addpath("./utils");
rng(0,'twister');
close all;clear all;clc
n = 1000;
p_thresh = 0.05;
%SAME DATA SAME NETWORK%
same_data_same_network_bias_ratio = 0;

load("data/perfect/C1.mat", "C1");
load("data/perfect/C2.mat", "C2");
X = [C1 C2];
y = [ones(1,size(C1,2))*1 ones(1,size(C2,2))*-1];
bias_counter = 0;
max_neurons = 10;
layer_count_range = [2, 10];
dim = 3;
train_fnc = 'traingd';
number_hidden_layers = 3;
net = create_network(number_hidden_layers, max_neurons, dim, train_fnc);

for i = 1:n
    ttest_bias = false;
    ranksum_bias = false;
    init_net = net;
    init_net = train(init_net, X, y);
    [possible_bias, results] = analyze_network(init_net, X, y, number_hidden_layers, false);

    if possible_bias

        for ttest_idx = 1:length(results(1, :))
            if results(1, ttest_idx) < p_thresh
                ttest_bias = true;
                break
            end
        end
        for ranksum_idx = 1:length(results(2, :))
            if results(2, ranksum_idx) < p_thresh
                ranksum_bias = true;
                break
            end
        end
           
        if ttest_bias && ranksum_bias
            bias_counter = bias_counter + 1;
            
        end
       
    end
end

fprintf("bias pct for same data same network n = %d: %.3f", n, bias_counter/n)

%SAME DATA NEW NETWORK%
bias_counter = 0;

for i = 1:n
    ttest_bias = false;
    ranksum_bias = false;
    init_net = create_and_train_network(number_hidden_layers, max_neurons, dim, train_fnc, X, y);
    [possible_bias, results] = analyze_network(init_net, X, y, number_hidden_layers, false);

    if possible_bias
        for ttest_idx = 1:length(results(1, :))
            disp(results(1, ttest_idx))
            if results(1, ttest_idx) < p_thresh
                ttest_bias = true;
                break
            end
        end

        for ranksum_idx = 1:length(results(2, :))
            disp(results(2, ranksum_idx))
            if results(2, ranksum_idx) < p_thresh
                ranksum_bias = true;
                break
            end
        end
           
        if ttest_bias && ranksum_bias
            bias_counter = bias_counter + 1;
            
        end


    end
end

fprintf("bias pct for same data new network n = %d: %.3f", n, bias_counter/n)