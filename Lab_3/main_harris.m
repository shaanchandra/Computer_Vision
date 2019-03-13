% image = imread('./person_toy/00000001.jpg');
image = imread('./pingpong/0000.jpeg');
image = im2double(image);
image = rgb2gray(image);

%(image,sigma_gaussian,filter_size,window_size,threshold)
[H,r,c] = harris_corner_detector(image,0.5,5,5,0.00001); 

% %Under rotation
image = imrotate(image,90);
[H,r,c] = harris_corner_detector(image,0.5,5,5,0.00001); 