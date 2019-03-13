
% img = imread('./synth1.pgm');
% img = im2double(img);
% 
% img2 = imread('./synth2.pgm');
% img2 = im2double(img2);

img = imread('./sphere1.ppm');
img = im2double(img);
img = rgb2gray(img);

img2 = imread('./sphere2.ppm');
img2 = im2double(img2);
img2 = rgb2gray(img2);

% [h, w, ~] = size(img);
% [x, y] = meshgrid(8:15:h-7, 8:15:w-7);
% XY = zeros(floor(h/15), floor(w/15), 2);
% XY(:, :, 1) = x;
% XY(:, :, 2) = y;
% XY = reshape(XY, [], 2);
[vx, vy, r, c, fig] = lucas_kanade(img, img2);
% fig = figure();
% imshow(img);
% hold on;
% 
% quiver(c, r, vx, vy, 'r')
% 
% visualize_optical_flow(img, v, XY, true);