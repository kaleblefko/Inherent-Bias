function plot_data(C1, C2, dimensions)
    figure(1);
    if dimensions==2
        scatter(C1(1,:), C1(2,:), MarkerEdgeColor="red")
        hold on
        scatter(C2(1,:), C2(2,:), MarkerEdgeColor="blue")
        xlabel("x1")
        ylabel("x2")
    elseif dimensions==3
        hold on
        scatter3(C1(1,:),C1(2,:),C1(3,:), 'r')
        scatter3(C2(1,:),C2(2,:),C2(3,:), 'b')
    else
        X = [C1 C2];
        y = [ones(1,size(C1,2))*1 ones(1,size(C2,2))*-1];
        Y = tsne(X');
        plot_latent_space(Y,y,1);
    end
end