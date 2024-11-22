function covs=produce_random_covs(l, min, max, N, diag)
    covs = zeros(N, l, l);
    for i=1:N
        if diag
            diagonal = min + (max - min) * rand(l, 1);
            covs(N,:,:) = diag(diagonal);
        else
            A = min_val + (max_val - min_val) * rand(l, l);
            matrix = A * A' + eye(l);
            covs(N,:,:) = matrix;
        end
    end
end