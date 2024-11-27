function [idx1, idx2] = get_random_pair_indices(X)
    idx = randi(size(X, 2), 1, 2);
    while idx(1) == idx(2)
        idx(2) = randi(size(X, 2));
    end
    idx1 = idx(1);
    idx2 = idx(2);
end

