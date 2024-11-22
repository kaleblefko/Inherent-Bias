function [m, cov]=produce_m_and_cov(l, m_minmax, cov_minmax, diag_cov, mode)
    m = produce_random_mean(l, m_minmax(1), m_minmax(2));
    cov = produce_random_cov(l, cov_minmax(1), cov_minmax(2), diag_cov);
    if diag_cov
        mask = eye(size(cov));
        cov = cov .* mask;
    end
end