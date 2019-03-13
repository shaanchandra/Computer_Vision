% createGabor( sigma, theta, lambda, psi, gamma )
sigma = 2;
theta = 1;
lambda = 10;
psi = 0;
gamma = 1/3;

%Detect changes in theta
figure(1)
subplot_index = 1;
changes = [0,1/2,1];
for theta_change = changes
    subplot(3,3,subplot_index)
    myGabor = createGabor(sigma, theta_change, lambda, psi, gamma);
    imshow(myGabor(:,:,2))
    subplot_index = subplot_index+1;
    title(['\theta = ',num2str(theta_change)])
end


%Detect changes in sigma
% figure(2)
% subplot_index = 1;
changes = linspace(1,3,3);
for sigma_change = changes
    subplot(3,3,subplot_index)
    myGabor = createGabor(sigma_change, theta, lambda, psi, gamma);
    imshow(myGabor(:,:,2))
    subplot_index = subplot_index+1;
    title(['\sigma = ',num2str(sigma_change)])
end



%Detect changes in gamma
% figure(3)
% subplot_index = 1;
changes = [1/4,1/2,3/4];
for gamma_change = changes
    subplot(3,3,subplot_index)
    myGabor = createGabor(sigma, 0, lambda, psi, gamma_change);
    imshow(myGabor(:,:,2))
    subplot_index = subplot_index+1;
    title(['\gamma = ',num2str(gamma_change)])
end


