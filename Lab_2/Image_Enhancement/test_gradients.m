% Script for Question 8: First-order derivative filters
image2 = imread('images/image2.jpg');
image2 = im2double(image2);
[Gx, Gy, im_magnitude, im_direction] = compute_gradient(image2);

figure
% Gradients in x-direction.
subplot(2, 2, 1);
imshow(abs(Gx)); % Absolute gradient values clipped at 0 and 1. 
title('Gx');

% Gradients in y-direction
subplot(2, 2, 2);
imshow(abs(Gy)); % Absolute gradient values clipped at 0 and 1. 
title('Gy');

% Magnitude
subplot(2, 2, 3);
imshow(im_magnitude); % Imshow clips values at 0 and 1. 
title('Image magnitude');

% Orientation plotting. We use HSV encoding for visualizing orientation
subplot(2, 2, 4);
[h, w] = size(im_direction);
min_dir = min(im_direction, [], 'all');
max_dir = max(im_direction, [], 'all');
colored_dir = zeros(h, w, 3);
colored_dir(:, :, 1) = (im_direction - min_dir) ./ (max_dir - min_dir); % Orientation encoded in hue 
colored_dir(:, :, 2) = 0.5; % Saturation fixed
colored_dir(:, :, 3) = (im_magnitude > 0.25) * 0.8; % Mask out pixels for which gradient magnitude is lower than certain threshold
colored_dir(:, :, :) = hsv2rgb(colored_dir(:, :, :));
imshow(colored_dir);
title('Image direction');
