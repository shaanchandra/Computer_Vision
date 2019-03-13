function featureTracking
% Main function for feature tracking
folder = './pingpong';
im = readImages(folder, 0:50);

% Change it to 0.25  and 0.35 for 0:5:50 
tau = 0.22;                              % Threshold for harris corner detection
% [pt_x, pt_y] = getKeypoints(im{1}, tau);
[~, pt_x, pt_y] = harris_corner_detector(im{1},0.5,5,5,0.00001);

ws = 7;    
points_out = zeros(1);% Tracking ws x ws patches
[track_x, track_y] = ...                    % Keypoint tracking
    trackPoints(pt_x, pt_y, im, ws);

% Uncomment to track points that go out of the frame
[track_x, track_y] = ...                    % Keypoint tracking
    trackPoints(pt_x, pt_y, im, ws);
track_x = track_x(points_out);
track_y = track_y(points_out);
  
% Visualizing the feature tracks on the first and the last frame
figure(2), imagesc(im{1}), hold off, axis image, colormap gray
hold on, plot(track_x.', track_y.', 'g.', 'linewidth', 2);
figure(3), imagesc(im{end}), hold off, axis image, colormap gray
hold on, plot(track_x.', track_y.', 'r', 'linewidth', 2);


function [track_x, track_y] = trackPoints(pt_x, pt_y, im, ws)
% Tracking initial points (pt_x, pt_y) across the image sequence
% track_x: [Number of keypoints] x [2]
% track_y: [Number of keypoints] x [2]

% Initialization
N = numel(pt_x);
nim = numel(im);
track_x = zeros(N, nim);
track_y = zeros(N, nim);
track_x(:, 1) = pt_x(:);
track_y(:, 1) = pt_y(:);

for t = 1:nim-1
    [track_x(:, t+1), track_y(:, t+1)] = ...
            getNextPoints(track_x(:, t), track_y(:, t), im{t}, im{t+1}, ws);
end
end


function [x2, y2, count_out] = getNextPoints(x, y, im1, im2, ws)
% Iterative Lucas-Kanade feature tracking
% x,  y : initialized keypoint position in im2
% x2, y2: tracked keypoint positions in im2
% ws: patch window size

im1 = im2double(im1);
im2 = im2double(im2);

num_iter = 5;
count = size(x, 1);

x2 = x;
y2 = y;
[Ix, Iy] = gradient(im1);

% get image patches
hw = floor(ws/2);

% Get image size
size_y = size(im1, 1);
size_x = size(im1, 2);
count_out = 1;
for iter=1:num_iter
    % Check if patch is outside the image
    for i=1:count
        if (y(i)-hw <= 0 || y(i)+hw > size_y || x(i)-hw <= 0 || x(i)+hw > size_x)
            points_out(count_out) = i;
            count_out = count_out + 1;
            continue;
        else
        [X, Y] = meshgrid(y(i)-hw:y(i)+hw,x(i)-hw:x(i)+hw);

        Ixyt = interp2(im1, Y, X, 'linear');
        Ixytplus1 = interp2(im2, Y, X, 'linear');
        
        
        It = Ixytplus1 - Ixyt;

        I_x = interp2(Ix, Y, X, 'linear');
        I_y = interp2(Iy, Y, X, 'linear');
        
        A = zeros(ws^2, 2);
        A(:, 1) = I_x(:);
        A(:, 2) = I_y(:);
        
        b = zeros(ws^2, 1);
        b(:, 1) = -It(:);
        
        P = A.' * A;
        Q = A.' * b;
        
        v = P\Q;
        
%         if (y2(i)<= 0 || y2(i)> size_y || x2(i)<= 0 || x2(i)> size_x)
%             continue;
%         end
        x2(i) = x2(i) + v(1);
        y2(i) = y2(i) + v(2);
        end        
    end
end
end



function im = readImages(folder, nums)
im = cell(numel(nums),1);

for i = 1:52
    if i<10
        image_name = strcat('./pingpong/000', num2str(i), '.jpeg');
        img = imread(image_name);
        img = im2double(img);
        im{i} = rgb2gray(img);
%         imshow(image2);
    end
    if i>=10
        image_name = strcat('./pingpong/00', num2str(i), '.jpeg');
        img = imread(image_name);
        img = im2double(img);
        im{i} = rgb2gray(img);
%         imshow(image2);
    end
end
end
end
function [keyXs, keyYs] = getKeypoints(im, tau)
% Detecting keypoints using Harris corner criterion  
% keyXs, keyYs: detected keypoints, with dimension [Number of keypoints] x [2]

close all;
sigma = 3;
im = im2double(im);
filter = fspecial('gaussian', sigma*2, sigma);

% Computing gradients
[Ix, Iy] = gradient(im);

% Gradient squared
Ix2 = Ix .* Ix;
Ixy = Ix .* Iy;
Iy2 = Iy .* Iy;

% Gaussian of the gradients
Ix_2 = imfilter(Ix2, filter);
I_xy = imfilter(Ixy, filter);
Iy_2 = imfilter(Iy2, filter);

% Computing Harris corner score
h_im = Ix_2 .* Iy_2 - I_xy.^2 - 0.04 * (Ix_2 + Iy_2) .^ 2;

% Normalizing
h_im = h_im - min(h_im(:));
h_im = h_im / max(h_im(:));

% Non maxima supression
h_im_nonmax = ordfilt2(h_im,15^2,ones(15));

% Apply local maxima and threshold
h_points = (h_im == h_im_nonmax) & (h_im > tau);

% Threshold the image
[keyYs, keyXs] = find(h_points);  % Return coordinates 

% Display the keypoints
figure, imagesc(im), axis image, colormap(gray), hold on;
plot(keyXs, keyYs, 'g.', 'linewidth', 3);
end