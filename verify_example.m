addpath("./utils");
C1 = load("./saved_data/C1.mat").C1;
C2 = load("./saved_data/C2.mat").C2;
net = load("./saved_data/net.mat").net;


X = [C1 C2];
y = [ones(1,size(C1,2))*1 ones(1,size(C2,2))*-1];

[h1, p1, h2, p2, c1_pdists, c2_pdists] = compare_distributions(X, y)
analyze_network(net, X, y, 4, false)
