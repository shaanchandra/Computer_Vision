function [ imOut ] = denoise( image, kernel_type, varargin)

switch kernel_type
    case 'box'
        imOut = imboxfilt(image, varargin{1});
        imshow(imOut);
%         fprintf('Not implemented\n')
    case 'median'
        imOut = medfilt2(image, [varargin{1}, varargin{1}]);
        imshow(imOut);
%         fprintf('Not implemented\n')
    case 'gaussian'
%         extracting sigma and kernel size from varargin
        sigma = varargin{1};
        sz = varargin{2};
        
%         Creating Gaussian filter of specified sigma and size 
        filter = gauss2D(sigma , sz);
%         Turning it into column blocks
        filter = filter(:);
%         Transforming the image to double for processing
        image = im2double(image);
%         Padding the image with appropriate padding size
        image_pad = padarray(image, [floor(sz/2) floor(sz/2)]);
%        Turning image into column blocks 
        C = im2col(image_pad, [sz sz], 'sliding');
%         Applyting element-wise operation on C(image) with filter
        C_filter = sum(bsxfun(@times, C, filter), 1);
%         Converting blocks of columns back into an image
        imOut = col2im(C_filter, [sz sz], size(image_pad), 'sliding');
        imshow(imOut);
%         fprintf('Not implemented\n')
end
end
