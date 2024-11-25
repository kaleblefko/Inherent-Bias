addpath("./utils");

close all;clc
randn('seed', 0);

N1_minmax = [500, 1000];
N2_minmax = [500, 1000];
N_mode = 3;
l = 2;
m_minmax_c1 = [0, 50];
m_minmax_c2 = [25, 75];
cov_minmax_c1 = [10, 40];
cov_minmax_c2 = [20, 60];
diag_cov = false;

[C1, C2]=produce_set(N_mode, l, m_minmax_c1, m_minmax_c2, cov_minmax_c1, cov_minmax_c2, diag_cov, N1_minmax, N2_minmax);
X = [C1 C2];
y = [ones(1,size(C1,2))*1 ones(1,size(C2,2))*-1];
plot_data(C1, C2, 2);

disp('Analyzing input data...');
[h_ttest, p_ttest, p_ranksum, h_ranksum] = compare_distributions(X,y);


num_hidden_layers = 5;
max_neurons = 100;
train_fnc = 'traingdm';
plot_latent = true;

net=create_and_train_network(num_hidden_layers, max_neurons, l, train_fnc, X, y);
analyze_network(net, X, y, 3, plot_latent);

save('./saved_data/C1.mat')
save('./saved_data/C2.mat')
save('./saved_data/net.mat')






