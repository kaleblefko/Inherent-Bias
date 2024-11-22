function mean=produce_random_mean(l, min, max)
    mean = zeros(1, l);
    for d=1:l
        mean(d) = unifrnd(min, max);
    end
end