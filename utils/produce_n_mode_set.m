function [C1, C2]=produce_n_mode_set(N_mode, l, m_minmax_c1, m_minmax_c2, cov_minmax_c1, cov_minmax_c2, diag_cov, N1_minmax, N2_minmax, even_mode_spread)
    N1 = randi([N1_minmax(1) N1_minmax(2)],1);
    N2 = randi([N2_minmax(1) N2_minmax(2)],1);

    m_sz = [l 1];
    cov_sz = [l l];
   
    N1_per_mode = [];
    N2_per_mode = [];

    C1 = [];
    C2 = [];

    for i=1:N_mode
        if even_mode_spread
            N1_per_mode = [N1_per_mode, floor(N1/N_mode)];
            N2_per_mode = [N2_per_mode, floor(N1/N_mode)];
        end
        if i==N_mode
            N1_per_mode(i) = N1_per_mode(i) + mod(N1,N_mode);
            N2_per_mode(i) = N2_per_mode(i) + mod(N2,N_mode);
        end
    end
    
    for i=1:length(N1_per_mode)
        [m1, cov1] = produce_m_and_cov(m_sz, m_minmax_c1, cov_sz, cov_minmax_c1, true, 1);
        C1 = [C1; mvnrnd(m1, cov1, N1_per_mode(i))];
    end

    for i=1:length(N2_per_mode)
        [m2, cov2] = produce_m_and_cov(m_sz, m_minmax_c2, cov_sz, cov_minmax_c2, true, 1);
        C2 = [C2; mvnrnd(m2, cov2, N2_per_mode(i))];
    end
    C1=C1';
    C2=C2';
end