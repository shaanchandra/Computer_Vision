function imOut = compute_LoG(image, LOG_type)

switch LOG_type
    case 1
        %method 1
        % Apply gaussian filter
        gaus_f = fspecial('gaussian', 5, 0.5); 
        imOut = imfilter(image, gaus_f);
        % Apply second-derivative/Laplacian filter
        lapl_f = fspecial('laplacian');
        imOut = imfilter(imOut, lapl_f);

    case 2
        %method 2
        % Laplacian of Gaussian filter
        log_f = fspecial('log', 5, 0.5);
        imOut = imfilter(image, log_f);

    case 3
        %method 3
        % Difference of Gaussians with ratio 1.6
        gaus_1 = fspecial('gaussian', 5, 0.5 * sqrt(1.6));
        gaus_2 = fspecial('gaussian', 5, 0.5 / sqrt(1.6));
        diff_filter = gaus_1 - gaus_2;
        imOut = imfilter(image, diff_filter);

end
end

