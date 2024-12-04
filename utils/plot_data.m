function plot_data(C1, C2, dimensions)
    if dimensions==2
        figure(1);
        scatter(C1(1,:), C1(2,:), MarkerEdgeColor="red", DisplayName='C1')
        hold on
        scatter(C2(1,:), C2(2,:), MarkerEdgeColor="blue", DisplayName='C2')
        xlabel("x1")
        ylabel("x2")
        legend('Location','southeastoutside');
        grid on
        title('2 Dimensional Input Data')
    elseif dimensions==3
        figure(1);
        hold on
        scatter3(C1(1,:),C1(2,:),C1(3,:), 'r', DisplayName='C1')
        scatter3(C2(1,:),C2(2,:),C2(3,:), 'b', DisplayName='C2')
        xlabel("x1")
        ylabel("x2")
        zlabel("x3")
        legend('Location','southeastoutside');
        grid on
        title('3 Dimensional Input Data')
    else
        X = [C1 C2];
        y = [ones(1,size(C1,2))*1 ones(1,size(C2,2))*-1];
        Y = tsne(X');
        plot_latent_space(Y,y,1,X);
    end
end