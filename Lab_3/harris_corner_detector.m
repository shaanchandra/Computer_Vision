function [H,r,c] = harris_corner_detector(image,sigma_gaussian_1, sigma_gaussian_2,filter_size,window_size,threshold)
    g = fspecial('gaussian',filter_size,sigma_gaussian_1); % sigma_gaussian
    [Gx,Gy] = gradient(g);

    %Calculate Ix and Iy
    Ix = imfilter(image,Gx,'symmetric');
    Iy = imfilter(image,Gy,'symmetric');

    g = fspecial('gaussian',filter_size,sigma_gaussian_2);
    %Calculate Q
    A = imfilter(Ix.^2,g,'symmetric');
    B = imfilter(Ix.*Iy,g,'symmetric');
    C = imfilter(Iy.^2,g,'symmetric');
    %Calculate H
    H = (A.*C-B.^2)-0.04*(A+C).^2;
    %plot image derivatives (Ix,Iy)
%     figure()
%     title("Ix");
%     [h, w] = size(Ix);
%     img = zeros(h, w, 3);
%     img(:,:,1) = max(Ix, 0);
%     img(:,:,2) = abs(Ix);
%     img(:,:,3) = abs(min(Ix, 0));
%     imshow(img*2)
%     figure()
%     title("Iy");
%     [h, w] = size(Iy);
%     img = zeros(h, w, 3);
%     img(:,:,1) = max(Iy, 0);
%     img(:,:,2) = abs(Iy);
%     img(:,:,3) = abs(min(Iy, 0));
%     imshow(img*2)

    %corner detection
    if rem(window_size,2)==0
        window_size = window_size+1;
    end
    lr = (window_size-1)/2;
    [row, col] = size(H);
    corners = [];
    found_loc_max = 0;
    for i = 1:row
        for j = 1:col
            from_row = max(i-lr,1);
            to_row = min(i+lr,row);
            from_col = max(j-lr,1);
            to_col = min(j+lr,col);
            % Check for cornerness being greater than certain threshold and
            % greater than points in neighborhood
            local_max = (H(i,j) == max(max(H(from_row:to_row,from_col:to_col))) & H(i,j)>threshold);
            if local_max == 1
                found_loc_max = 1;
                corners = [corners;[i,j]];
            end
        end
    end
    
    % Sanity check if no corners were detected
    if found_loc_max == 1
        r = corners(:,1);
        c = corners(:,2);
    else
        r = [];
        c = [];
    end
end

