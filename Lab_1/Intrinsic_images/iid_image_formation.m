ball = imread('ball.png');
albedo = imread('ball_albedo.png');
shading = imread('ball_shading.png');

% Converting images to double for processing
ball = im2double(ball);
albedo = im2double(albedo);
shading = im2double(shading);

%Getting different channels of albedo
alb_ch1 = albedo(:,:,1);
alb_ch2 = albedo(:,:,2);
alb_ch3 = albedo(:,:,3);

% Channel values of the reconstructed image from albedo and shading
new_ch1 = alb_ch1 .* shading;
new_ch2 = alb_ch2 .* shading;
new_ch3 = alb_ch3 .* shading;

% creating the reconstructed image from individual channels
new_ball = cat(3, new_ch1, new_ch2, new_ch3);

figure(1)
% subplot(2,2,1)
imshow(new_ball);
title("Re-constructed image");
% subplot(2,2,2)
figure(2)
imshow(ball)
title("Original image");
% subplot(2,2,3)
figure(3)
imshow(albedo)
title("Albedo image");
% subplot(2,2,4)
figure(4)
imshow(shading)
title("Shading image");
