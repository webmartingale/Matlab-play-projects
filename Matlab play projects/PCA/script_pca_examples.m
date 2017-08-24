%Create data

clear
clc
x = 12+ randn(100,1)*10;
y = 8+ randn(100,1)*2;
scatter(x,y)
xlim([-40,40]), ylim([-40,40])
D = [x'; y']';

pause on

%Plot a half circle from rotated point from the origin circle
figure;
M = rotM(pi/180);
v = [1;0];
for i = 1:180
    vt = (M^i)*v;
    scatter(vt(1), vt(2));
    hold on;
    pause(1.0/1000);
end

%Rotate a 2d normal distribution scatter plot + PCA lines
figure;
M = rotM(pi/180);
for i = 1:360
    plotPCA_2D(((M^i)*D')');
    pause(3.0/1000);
end

%Check a more complicated data with multiple distributions added
Mrot = rotM(pi/3);

Drot = (Mrot * D')';
%scatter(Drot(:,1), Drot(:,2))
D_comb = [D; Drot];
%scatter(D_comb(:,1), D_comb(:,2))

figure;
M = rotM(pi/180);
for i = 1:360
    plotPCA_2D(((M^i)*D_comb')');
    pause(3.0/1000);
end


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