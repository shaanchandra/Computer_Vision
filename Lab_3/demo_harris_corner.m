image = imread('./person_toy/00000001.jpg');
% image = imread('./pingpong/0000.jpeg');
image = im2double(image);
image = rgb2gray(image);

%(image,sigma_gaussian_1,sigma_gaussian_2,filter_size,window_size,threshold)
image = imrotate(image,0);
[H,r,c] = harris_corner_detector(image,0.5,0.5,5,7,1e-5); 

fig = figure();
imshow(image,'InitialMagnification',100);
hold on;
plot(c,r,'*','LineWidth',2,'MarkerSize',10,'Color',[1 0.2 0.2]);

% %Under rotation
% image = imrotate(image,45);
% [H,r,c] = harris_corner_detector(image,0.5,5,7,0.00001); 