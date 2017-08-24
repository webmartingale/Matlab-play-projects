%Rotator + transformer
clear
clc

for j = 1:10
    
    n=360;
    %Generate data
    x = 0+ randn(100,1)*10;
    y = 0 + randn(100,1)*2;
      
        
    for i = 1:n
    %Generate rotated data    
    D = [x'; y']';     
    Mrot = rotM(i*2*pi/n);
    Drot = (Mrot * D')';
    offsetx = 50*sin(10*i/n);
    offsety = offsetx/2.0;
    Drot(:,1) = Drot(:,1) + repmat(offsetx, length(x), 1);
    Drot(:,2) = Drot(:,2) + repmat(offsety, length(x), 1);
    maxlim = max(max(abs(Drot)))*1.2;
    %PCA
    means = mean(Drot, 1);    
    Dnorm = Drot - repmat(means, length(x), 1);
    [coeff, score, latent] = pca(Dnorm);
    
    %Original plot with PCA lines  
    subplot(3,1,1);
    plotPCA_2D(Drot, coeff, score, latent);
    xlim([-maxlim,maxlim]), ylim([-maxlim,maxlim]);
    title('Original data');
    %xlabel(['eigenvalues:', num2str(latent(1)), '; ', num2str(latent(2))]);
    
    %PCA transformed data
    subplot(3,1,2);
    D_pca = (coeff' * Dnorm')';    
    scatter(D_pca(:,1), D_pca(:,2));
%     xlim([-40,40]), ylim([-40,40])
%     xlim([-maxlim,maxlim]), ylim([-maxlim,maxlim]);
    title('PCA transformed data. ');

    %De-rotated
    subplot(3,1,3);    
    D_orig = (coeff * D_pca')';    
    D_orig = D_orig + repmat(means, length(x), 1);
    scatter(D_orig(:,1), D_orig(:,2));
%     xlim([-40,40]), ylim([-40,40])
    xlim([-maxlim,maxlim]), ylim([-maxlim,maxlim]);
    title('Transformed back to original data.');
    k = waitforbuttonpress;
    end
end