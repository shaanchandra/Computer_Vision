% Question 8: Visualize HSV color circle for report
h = 500;
w = 500;

im = zeros(h, w, 3);
im(:, :, 2) = 1.0;
im(:, :, 3) = 1.0;

for x=1:w
    for y=1:h
        % For every pixel: determine angle, and use it as hue value
        d = sqrt((x - w/2)^2 + (y - h/2)^2);
        if d > h/2
            im(x, y, 3) = 0.0;
        else
            im(x, y, 1) = (atan2(y - h/2, x - w/2) / pi + 1) / 2;
        end
    end
end

im = hsv2rgb(im);
imshow(im);