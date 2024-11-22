close all;clc
randn('seed', 0);

N1 = [800, 800];
N2 = [800, 800];
X = [C1 C2];
y = [ones(1,size(C1,2))*1 ones(1,size(C2,2))*-1];
plot_data(C1, C2, 2);
disp('Analyzing input data...');
[h_ttest, p_ttest, p_ranksum, h_ranksum] = compare_distributions(X,y)
analyze_network(net, X, y, 3);







