function [m, cov]=produce_m_and_cov(m_sz, m_minmax, cov_sz, cov_minmax, diag_cov, mode)
    m = unifrnd(m_minmax(1), m_minmax(2), m_sz);
    cov = unifrnd(cov_minmax(1), cov_minmax(2), cov_sz);
    if diag_cov
        mask = eye(size(cov));
        cov = cov .* mask;
    end
end