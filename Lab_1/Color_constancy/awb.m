input_image = imread('awb.jpg');
gray = [128,128,128];

% Getting the original color channels
R = input_image(:,:,1);
G = input_image(:,:,2);
B = input_image(:,:,3);

% Converting to double for computation
R = double(R);
G = double(G);
B = double(B);

mean_R = double(mean2(R));
mean_G = double(mean2(G));
mean_B = double(mean2(B));
% new_R = gray(1) + (R-mean_R);
% new_G = gray(2) + (G-mean_G);
% new_B = gray(3) + (B-mean_B);

% Linear transformation for the grey-world assumption model
new_R = (R /mean_R) *128;
new_G = (G /mean_G) *128;
new_B = (B /mean_B) *128;

new_R = uint8(new_R);
new_G = uint8(new_G);
new_B = uint8(new_B);

new_image = cat(3,new_R,new_G,new_B);
imshow(new_image)