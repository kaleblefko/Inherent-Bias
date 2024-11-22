function cov=produce_random_cov(l, min, max, diag)
    if diag
        diagonal = min + (max - min) * rand(l, 1);
        cov = eye(l) .* diagonal';
    else
        A = min + (max - min) * rand(l, l);
        matrix = A * A' + eye(l);
        cov = matrix;
    end
end