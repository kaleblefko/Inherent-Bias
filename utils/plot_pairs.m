function [ratio]=plot_pairs(C1_embedded, C2_embedded, C1, C2, idxs)
    c1_pair_dist = pdist([C1(:, idxs(1))'; C1(:, idxs(2))']);
    legend_entry_c1_pair = sprintf("C1 Pair Distance %.2f", c1_pair_dist);
    highlight_point(C1_embedded(:, idxs(1))', 'green', 2);
    highlight_point(C1_embedded(:, idxs(2))', 'green', 2);
    pair1_x = [C1_embedded(1, idxs(1)), C1_embedded(1, idxs(2))];
    pair1_y = [C1_embedded(2, idxs(1)), C1_embedded(2, idxs(2))];
    plot(pair1_x, pair1_y, 'green', 'DisplayName', legend_entry_c1_pair);

    c2_pair_dist = pdist([C2(:, idxs(3))'; C2(:, idxs(4))']);
    legend_entry_c2_pair = sprintf("C2 Pair Distance %.2f", c2_pair_dist);
    highlight_point(C2_embedded(:, idxs(3))', 'black', 2);
    highlight_point(C2_embedded(:, idxs(4))', 'black', 2);
    pair2_x = [C2_embedded(1, idxs(3)), C2_embedded(1, idxs(4))];
    pair2_y = [C2_embedded(2, idxs(3)), C2_embedded(2, idxs(4))];
    plot(pair2_x, pair2_y, 'black', 'DisplayName', legend_entry_c2_pair);

    ratio = c1_pair_dist/c2_pair_dist;
end