addpath("./utils");

close all;clear all;clc

load("Examples/example_1/C1.mat", "C1");
load("Examples/example_1/C2.mat", "C2");
load("Examples/example_1/net.mat", "net");

X = [C1 C2];
y = [ones(1,size(C1,2))*1 ones(1,size(C2,2))*-1];

Y = tsne(X');
plot_latent_space(Y,y,1);

disp('Analyzing input data...');
[h_ttest, p_ttest, p_ranksum, h_ranksum] = compare_distributions(X,y)

analyze_network(net, X, y, 3, true);




