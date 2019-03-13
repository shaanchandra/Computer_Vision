% test your code by using this simple script

clear
clc
close all

I = imread('peppers.png');

imshow(I);
hold on;
J = ConvertColorSpace(I,'opponent');
 
close all
hold on;
J = ConvertColorSpace(I,'rgb');

close all
hold on;
J = ConvertColorSpace(I,'hsv');

close all
hold on;
J = ConvertColorSpace(I,'ycbcr');

close all
hold on;
J = ConvertColorSpace(I,'gray');