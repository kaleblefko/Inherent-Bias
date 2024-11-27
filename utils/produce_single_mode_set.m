function [C1, C2]=produce_single_mode_set(l, m_minmax_c1, m_minmax_c2, cov_minmax, diag_cov, N1_minmax, N2_minmax)
    N1 = randi([N1_minmax(1) N1_minmax(2)],1);
    N2 = randi([N2_minmax(1) N2_minmax(2)],1);

    m1 = produce_random_mean(l, m_minmax_c1(1), m_minmax_c1(2));
    m2 = produce_random_mean(l, m_minmax_c2(1), m_minmax_c2(2));
    cov = produce_random_cov(l, cov_minmax(1), cov_minmax(2), diag_cov);

    C1 = mvnrnd(m1, cov, N1)';
    C2 = mvnrnd(m2, cov, N2)';
end