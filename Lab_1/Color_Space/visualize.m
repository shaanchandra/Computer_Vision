function visualize(input_image)
ch1 = input_image(:,:, 1);
ch2 = input_image(:,:,2);
ch3 = input_image(:,:,3);

size_input_image = size(input_image);
if size_input_image(3)==3
    subplot(2,2,1);
    imshow(input_image);
    title("HSV Image");

else
    ch4 = input_image(:,:,4);
    subplot(2,2,1);
    imshow(ch4);
%     title("");

end

subplot(2,2,2);
imshow(ch1);
title("Hue");
subplot(2,2,3);
imshow(ch2);
title("Saturation");
subplot(2,2,4);
imshow(ch3);
title("Value");


end

