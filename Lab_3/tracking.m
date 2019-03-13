use_pingpong = true;
if use_pingpong
    filename = './pingpong_animation.gif';
    img2 = imread('./pingpong/0000.jpeg');
else
    filename = './person_toy_animation.gif';
    img2 = imread('./person_toy/00000001.jpg');
end
img2 = im2double(img2);
img2 = rgb2gray(img2);
[H,r,c] = harris_corner_detector(img2,1.0,2.0,9,7,1e-6); 
vel_c = 0.91;

for i=1:52
    img = img2;
    if use_pingpong
        img_name = strcat('./pingpong/',sprintf('%04d',i),'.jpeg');
    else
        img_name = strcat('./person_toy/',sprintf('%08d',i+1),'.jpg');
    end
    img2 = imread(img_name);
    img2 = im2double(img2);
    img2 = rgb2gray(img2);

    [sr,~] = size(r);
    XY = zeros(sr, 2);
    XY(:,1) = int32(r);
    XY(:,2) = int32(c);
    v = lucas_kanade(img, img2, XY, 7);
    h = figure(1);
    visualize_optical_flow(img, v * vel_c * 15, XY, false);
    c(:) = c(:) + v(:,1) * vel_c;
    r(:) = r(:) + v(:,2) * vel_c;
    drawnow
    frame = getframe(h); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 
    if i == 1 
        imwrite(imind,cm,filename,'gif','Loopcount',inf); 
    else 
        imwrite(imind,cm,filename,'gif','WriteMode','append'); 
    end 
end