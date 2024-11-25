function plot_data(C1, C2, dimensions)
    figure;
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