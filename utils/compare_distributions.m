function [h_ttest, p_ttest, p_ranksum, h_ranksum]=compare_distributions(dataset, y)
    c1_pairwise_distances = pdist(dataset(:,(y==1))');
    c2_pairwise_distances = pdist(dataset(:,(y==-1))');
    c1_clean = c1_pairwise_distances(~isnan(c1_pairwise_distances));
    c2_clean = c2_pairwise_distances(~isnan(c2_pairwise_distances));
    [h_ttest,p_ttest] = ttest2(c1_pairwise_distances, c2_pairwise_distances);
    [p_ranksum, h_ranksum] = ranksum(c1_clean, c2_clean);
end