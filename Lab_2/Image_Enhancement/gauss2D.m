function G = gauss2D( sigma , kernel_size )
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end
    % Apply two 1D gaussian filters
    Gx = gauss1D(sigma,kernel_size);
    G = Gx'*Gx;
end
