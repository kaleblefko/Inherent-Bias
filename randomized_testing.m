addpath("./utils");
close all; clear all; clc

l = [2, 3, 4, 5, 6, 7, 8, 9, 10];
N_modes = [1, 5, 10, 100];
N_min = [1, 100, 500, 1000];
N_max = [100, 500, 1000, 5000];
mean_min = [1, 10, 25, 50, 100, 150];
mean_max = [10, 25, 50, 100, 150, 200];
cov_min = [10, 20, 30, 40, 50, 60, 70];
cov_max = [20, 30, 40, 50, 60, 70, 80];
diag = [true, false];

examples = 1;

number_hidden_layers = 3;
max_neurons = 10;
train_fnc = 'traingd';

% [C1, C2]=produce_set(N_mode, l, m_minmax_c1, m_minmax_c2, cov_minmax_c1, cov_minmax_c2, diag_cov, N1_minmax, N2_minmax)

% Here we will create a dataset for every combination of the above
% parameters and test it on random models

[dim_grid, modes_grid, n_min_grid, n_max_grid, mean_max_grid, mean_min_grid, ...
    cov_max_grid, cov_min_grid, diag_grid] = ndgrid(l, N_modes, N_min, N_max,...
    mean_max, mean_min, cov_max, cov_min, diag);

dim_vec = dim_grid(:);
modes_vec = modes_grid(:);
n_min_vec = n_min_grid(:);
n_max_vec = n_max_grid(:);
mean_max_vec = mean_max_grid(:);
mean_min_vec = mean_min_grid(:);
cov_max_vec = cov_max_grid(:);
cov_min_vec = cov_min_grid(:);
diag_vec = diag_grid(:);

num_combinations = numel(dim_vec);

for idx = 1:num_combinations
    dim = dim_vec(idx);
    modes = modes_vec(idx);
    n_min = n_min_vec(idx);
    n_max = n_max_vec(idx);
    mean_max = mean_max_vec(idx);
    mean_min = mean_min_vec(idx);
    cov_max = cov_max_vec(idx);
    cov_min = cov_min_vec(idx);
    diag = diag_vec(idx);
    
    fprintf(['Processing Combination %d/%d: dim=%d, modes=%d, n_min=%d, n_max=%d, ' ...
        'mean_max=%d, mean_min=%d, cov_max=%d, cov_min=%d, diag=%d\n'], ...
        idx, num_combinations, dim, modes, n_min, n_max, mean_max, mean_min, ...
        cov_max, cov_min, diag);

    mean_minmax = [mean_min mean_max];
    if mean_min > mean_max
        mean_minmax = [mean_max mean_min];
    end
    cov_minmax = [cov_min cov_max];
    if cov_min > cov_max
        cov_minmax = [cov_max cov_min];
    end
    N_minmax = [n_min n_max];
    if n_min > n_max
        N_minmax = [n_max n_min];
    end

    [C1, C2] = produce_set(modes, dim, mean_minmax, mean_minmax, cov_minmax, cov_minmax, diag, N_minmax, N_minmax);
    X = [C1 C2];
    y = [ones(1,size(C1,2))*1 ones(1,size(C2,2))*-1];

    if any(isnan(C1), 'all') || any(isnan(C2), 'all')
        fprintf('Skipping this combination: NaN detected in C1 or C2\n');
        continue;
    end
    disp('Analyzing input data...');
    [h_ttest, p_ttest, p_ranksum, h_ranksum] = compare_distributions(X,y);


    %TODO: If input data is biased, check the latent spaces for increasing
    %p values from the input
    if isnan(h_ranksum) || isnan(h_ttest)
        disp('Combination not suitable.')
        continue;
    end

    if ~h_ranksum || ~h_ttest
        disp('Combination not suitable.')
        continue;
    end

    net = create_and_train_network(number_hidden_layers, max_neurons, dim, train_fnc, X, y);
    possible_bias = analyze_network(net, X, y, number_hidden_layers, false);

    if possible_bias
        dir = sprintf('./Examples/example_%d/',examples);
        while(isfolder(dir))
            examples = examples + 1;
            dir = sprintf('./Examples/example_%d/',examples);
        end
        mkdir(dir);
        save(dir+"C1.mat","C1");
        save(dir+"C2.mat","C2");
        save(dir+"net.mat","net");
        file = fopen(dir+"Params.txt", 'w');
        diary(dir+"Params.txt");
        fprintf(file, ['Parameters: dim=%d, modes=%d, n_min=%d, n_max=%d ' ...
        'mean_max=%d, mean_min=%d, cov_max=%d, cov_min=%d, diag=%d\n'], ...
        dim, modes, n_min, n_max, mean_max, mean_min, cov_max, cov_min, diag);
        possible_bias = analyze_network(net, X, y, number_hidden_layers, false);
        fclose(file);
        diary off;
    end
end





