function [Gx, Gy, im_magnitude, im_direction] = compute_gradient(image)
    sobel_x = [[1, 0, -1]; [2, 0, -2]; [1, 0, -1]]; % Define sobel filter in x-direction
    sobel_y = [[1, 2, 1]; [0, 0, 0]; [-1, -2, -1]]; % Define sobel filter in y-direction
    % Apply gradient filters
    Gx = imfilter(image, sobel_x);
    Gy = imfilter(image, sobel_y);
    % Determine magnitude
    im_magnitude = sqrt(Gx.^2 + Gy.^2);
    % For orientation, apply atan2 (values in range of -pi to pi)
    im_direction = atan2(Gy, Gx);
end

