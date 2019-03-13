% Script for Question 9: comparing different methods for second-order
% derivative
image2 = imread('images/image2.jpg');
image2 = im2double(image2);

figure
for i=1:3
    subplot(1, 3, i);
    imOut = compute_LoG(image2, i);
    imOut = imOut / max(imOut, [], 'all') * 2; % Normalize and rescale by 2 for better visualization
    imshow(imOut);
    title(strcat('Method ', num2str(i)));
end

% Plot for comparing LoG and DoG
% figure
% log_f = fspecial('log', 5, 0.5);
% plot(-2:2, log_f(3, :), 'Linewidth', 1.5);
% hold on;
% title('Comparing LoG and DoG approximation');
% xlabel('x direction');
% ylabel('Filter value at h(x,0)');
% sigma_1 = 0.5 * sqrt(1.6);
% sigma_2 = 0.5 / sqrt(1.6);
% gaus_1 = fspecial('gaussian', 5, sigma_1);
% gaus_2 = fspecial('gaussian', 5, sigma_2);
% diff_filter = gaus_1 - gaus_2;
% plot(-2:2, diff_filter(3, :) / (sigma_1 - sigma_2), 'Linewidth', 1.5); % , 'DoG'
% scaled_diff_filter = diff_filter * min(log_f, [], 'all') / min(diff_filter, [], 'all');
% plot(-2:2, scaled_diff_filter(3, :), 'Linewidth', 1.5); % , 'Scaled DoG'
% legend({'LoG', 'DoG ratio 1.6', 'DoG ratio 1.6 rescaled'}, 'Location', 'east');
