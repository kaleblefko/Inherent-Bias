addpath("./utils");

l = [2, 3, 4, 5, 6, 7, 8, 9, 10, 50, 100];
N_modes = [1, 5, 10, 100];
N1 = [100, 500, 1000, 5000];
N2 = [100, 500, 1000, 5000];
diag = [true, false];

% [C1, C2]=produce_set(N_mode, l, m_minmax_c1, m_minmax_c2, cov_minmax_c1, cov_minmax_c2, diag_cov, N1_minmax, N2_minmax)


% Here we will create a dataset for every combination of the above
% parameters and test it on random models