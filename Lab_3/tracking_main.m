% filename = './person_toy_animation.gif';
% img2 = imread('./person_toy/00000001.jpg');
% img2 = im2double(img2);
% 
% for i=1:100
%     img = img2;
%     img_name = strcat('./person_toy/',sprintf('%08d',i+1),'.jpg');
%     img2 = imread(img_name);
%     img2 = im2double(img2);

filename = './pingpong_animation.gif';
img2 = imread('./pingpong/0000.jpeg');
img2 = im2double(img2);
[H,r,c] = harris_corner_detector(img2,0.5,5,11,1e-5); 
for i=1:103
    img = img2;
    img_name = strcat('./pingpong/',sprintf('%04d',i+1),'.jpeg');
%     img_name = strcat('./person_toy/', sprintf('%08d',i+1), '.jpg');
    img2 = imread(img_name);
    img2 = im2double(img2);
  
    [sr,~] = size(r);
%     XY = zeros(sr, 2);
%     XY(:,1) = r;
%     XY(:,2) = c;
    [vx, vy, r, c, fig] = lucas_kanade(img, img2, int32(r), int32(c));
    r(:) = r(:) + int32(vx(:));
    c(:) = c(:) + int32(vy(:));
%     imshow(fig);
%     if i > 0
%         folder = './results/';
%         file_name = sprintf('%d.jpeg', i);
%         full_path = fullfile(folder, file_name);
%         saveas(fig, full_path, 'jpeg');
%         pause(1);
%     end
%     
end