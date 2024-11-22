function [h_ttest, p_ttest, p_ranksum, h_ranksum]=compare_distributions(dataset, y)
    c1_pairwise_distances = pdist(dataset(:,(y==1))');
    c2_pairwise_distances = pdist(dataset(:,(y==-1))');
    [h_ttest,p_ttest] = ttest2(c1_pairwise_distances, c2_pairwise_distances);
    [p_ranksum, h_ranksum] = ranksum(c1_pairwise_distances, c2_pairwise_distances);
end