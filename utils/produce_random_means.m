function means=produce_random_means(l, min, max, N)
    means = zeros(N, l);
    for i=1:N
        mean = zeros(l);
        for d=1:l
            mean(d) = unifrnd(min, max);
        end
        means(i, :) = mean;
    end
end