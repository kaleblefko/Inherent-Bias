function [h_ttest, p_ttest, p_ranksum, h_ranksum, c1_pairwise_distances, c2_pairwise_distances]=compare_distributions(dataset, y)
    c1_pairwise_distances = pdist(dataset(:,(y==1))');
    c2_pairwise_distances = pdist(dataset(:,(y==-1))');
    c1_clean = c1_pairwise_distances(~isnan(c1_pairwise_distances));
    c2_clean = c2_pairwise_distances(~isnan(c2_pairwise_distances));
    [h_ttest,p_ttest] = ttest2(c1_pairwise_distances, c2_pairwise_distances);
    if isempty(c1_clean) || isempty(c2_clean)
        warning('No data remaining for ranksum test after removing NaNs.');
        p_ranksum = NaN;
        h_ranksum = NaN;
        return;
    end
    [p_ranksum, h_ranksum] = ranksum(c1_pairwise_distances, c2_pairwise_distances);
end