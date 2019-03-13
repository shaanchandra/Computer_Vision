function v = lucas_kanade(image, sub_image, points, kernel_size)
    %Calculate gradients
    [Gx, Gy] = gradient(fspecial('gaussian',9,0.8));
    Ix = imfilter(image, -Gx, 'symmetric');
    Iy = imfilter(image, -Gy, 'symmetric');
    It = sub_image - image;
    % Prepare parameters
    [h, w, ~] = size(image);
    [no_points, ~] = size(points);
    v = zeros(no_points, 2);
    % For every point: estimate V_x and V_y by calculating the pseudo
    % inverse
    for i=1:no_points
        % Determine the patch 
        x_min = max(points(i, 1) - kernel_size, 1);
        x_max = min(points(i, 1) + kernel_size, h);
        y_min = max(points(i, 2) - kernel_size, 1);
        y_max = min(points(i, 2) + kernel_size, w);
        patch_Ix = Ix(x_min:x_max, y_min:y_max);
        patch_Iy = Iy(x_min:x_max, y_min:y_max);
        patch_It = It(x_min:x_max, y_min:y_max);
        % Estimate v
        A = cat(2, reshape(patch_Ix, [], 1), reshape(patch_Iy, [], 1));
        b = -reshape(patch_It, [], 1);
        v(i,:) = pinv(A) * b;
    end
        
end