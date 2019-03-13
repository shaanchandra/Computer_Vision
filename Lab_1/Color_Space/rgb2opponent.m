function [output_image] = rgb2opponent(input_image)
% converts an RGB image into opponent color space
r = input_image(:,:,1);
g = input_image(:,:,2);
b= input_image(:,:,3);

o1 = (r-g)/sqrt(2);
o2 = (r+g-2*b)/sqrt(6);
o3 = (r+g+b)/sqrt(3);

output_image = cat(3, o1,o2,o3);
end

