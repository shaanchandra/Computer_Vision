clear
clc
close all

% Reading images
albedo = imread('ball_albedo.png');
shading = imread('ball_shading.png');
ball = imread('ball.png');

% Converting images to double for processing
albedo = im2double(albedo);
shading = im2double(shading);


% defining new color
new_c = [0,255,0];
normalized_new_color = [new_c(1)/sum(new_c),new_c(2)/sum(new_c),new_c(3)/sum(new_c)];

%finding the original RGB color 
alb_ch1 = albedo(:,:,1);
alb_ch2 = albedo(:,:,2);
alb_ch3 = albedo(:,:,3);

% r,g,b have just the non-zero (non-black) region of the image, i.e., just
% the ball
[~,~,r] = find(alb_ch1);
[~,~,g] = find(alb_ch2);
[~,~,b] = find(alb_ch3);
disp('The true material color of the ball in RGB space:')
disp([r(1),g(1),b(1)])

% Setting values of the pixels to the new color(green)
size_albedo = size(albedo);
for ch3 = 1:size_albedo(3)
    for ch2 = 1:size_albedo(2)
        for ch1 = 1:size_albedo(1)
            if albedo(ch1,ch2,ch3)~=0
               albedo(ch1,ch2,ch3)=normalized_new_color(ch3);
            end
        end
    end
end

alb_ch1 = albedo(:,:,1);
alb_ch2 = albedo(:,:,2);
alb_ch3 = albedo(:,:,3);

% Reconstructing new image (recolored)
new_ch1 = alb_ch1 .* shading;
new_ch2 = alb_ch2 .* shading;
new_ch3 = alb_ch3 .* shading;
new_ball = cat(3, new_ch1, new_ch2, new_ch3);

figure(1)
% subplot(1,2,1)
imshow(new_ball)
title("Recolored image");
% subplot(1,2,2)
figure(2)
imshow(ball)
title("Original image");