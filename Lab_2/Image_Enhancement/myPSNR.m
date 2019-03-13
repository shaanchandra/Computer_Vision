function [ PSNR ] = myPSNR( orig_image, approx_image )
% fprintf('Not implemented\n')

% Converting images into double for processing
orig_image = im2double(orig_image);
approx_image = im2double(approx_image);

% Calculating PSNR
temp = double((orig_image - approx_image).^2);
temp = sum(temp(:));
sz = size(orig_image);
mse = double((1/(sz(1) * sz(2))) * temp);
rmse = sqrt(mse);
I_max = max(orig_image(:));
PSNR = 20 * log10(I_max/rmse);

end

