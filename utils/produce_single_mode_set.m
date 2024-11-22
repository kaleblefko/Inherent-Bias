function [C1, C2]=produce_single_mode_set(l, m_minmax_c1, m_minmax_c2, cov_minmax_c1, cov_minmax_c2, diag_cov, N1_minmax, N2_minmax)
    m_sz = [l 1];
    cov_sz = [l l];

    N1 = randi([N1_minmax(1) N1_minmax(2)],1);
    N2 = randi([N2_minmax(1) N2_minmax(2)],1);

    [m1, cov1] = produce_m_and_cov(m_sz, m_minmax_c1, cov_sz, cov_minmax_c1, true, 1);
    [m2, cov2] = produce_m_and_cov(m_sz, m_minmax_c2, cov_sz, cov_minmax_c2, true, 1);

    C1 = mvnrnd(m1, cov1, N1)';
    C2 = mvnrnd(m2, cov2, N2)';
end