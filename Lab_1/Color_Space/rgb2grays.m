function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods

% getting the original color channels
r = input_image(:,:,1);
g = input_image(:,:,2);
b= input_image(:,:,3);

% ligtness method
temp_max = max(r,g);
temp_min = min(r,g);
ch1 = (max(temp_max,b) + min(temp_min,b))/2;

% average method
 ch2 = (r+g+b)/3;
 
% luminosity method
ch3 = 0.21*r + 0.72*g + 0.07*b;

% built-in MATLAB function 
ch4 = rgb2gray(input_image);

output_image = cat(3,ch1,ch2,ch3, ch4); 
end

