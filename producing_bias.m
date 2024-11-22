addpath("./utils");

N_modes = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 50, 100];
l = [2, 3, 4, 5, 6, 7, 8, 9, 10, 50, 100];
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
% 
% save('C1.mat', 'C1');
% save('C2.mat', 'C2'); 
% save('net.mat', 'net');



