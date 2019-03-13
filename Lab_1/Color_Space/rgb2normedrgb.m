function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
r = input_image(:,:,1);
g = input_image(:,:,2);
b= input_image(:,:,3);

o1 = r./(r+g+b);
o2 = g./(r+g+b);
o3 = b./(r+g+b);

output_image = cat(3, o1,o2,o3);
end

