% [C1, C2]=produce_single_mode_set(2, [1,4], [2,6], [1, 4], [1, 4], true, [800, 800], [800, 800]);

[C1, C2]=produce_n_mode_set(1, 2, [1, 100], [1, 100], [30, 70], [30, 70], false, [800, 800], [800, 800], true);

plot_data(C1, C2, 2);


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

function [m, cov]=produce_m_and_cov(m_sz, m_minmax, cov_sz, cov_minmax, diag_cov, mode)
    m = unifrnd(m_minmax(1), m_minmax(2), m_sz);
    cov = unifrnd(cov_minmax(1), cov_minmax(2), cov_sz);
    if diag_cov
        mask = eye(size(cov));
        cov = cov .* mask;
    end
end

function plot_data(C1, C2, dimensions)
    figure
    if dimensions==2
        scatter(C1(1,:), C1(2,:), MarkerEdgeColor="red")
        hold on
        scatter(C2(1,:), C2(2,:), MarkerEdgeColor="blue")
        xlabel("x1")
        ylabel("x2")
    else
        embedded_C1 = run_umap(C1')';
        embedded_C2 = run_umap(C2')';
        scatter(embedded_C1(1,:), embedded_C1(2,:), MarkerEdgeColor="cyan")
        hold on
        scatter(embedded_C2(1,:), embedded_C2(2,:), MarkerEdgeColor="green")
        xlabel("embedded x1")
        ylabel("embedded x2")
    end
end


