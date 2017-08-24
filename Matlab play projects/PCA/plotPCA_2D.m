
function plotPCA_2D(D,  coeff, score, latent)
    
    s1 = sqrt(latent(1));
    s2 = sqrt(latent(2));
    scatter(D(:,1), D(:,2));
    maxlim = max(max(abs(D)))*1.2;
    xlim([-maxlim,maxlim]), ylim([-maxlim,maxlim]);
    hold on;
    c2 = [[0;0], coeff(:,1), [0;0], coeff(:,2)];
    plot(s1*c2(1,1:2), s1*c2(2,1:2), 'r-', 'linewidth', 3);
    plot(s2*c2(1,3:4), s2*c2(2,3:4), 'b-', 'linewidth', 3);
    title(['PCA eigenvalues: ', num2str(latent(1)), ', ', num2str(latent(2))]);
    assert(coeff(:,1)'*coeff(:,2) == 0);    
    hold off;
end
