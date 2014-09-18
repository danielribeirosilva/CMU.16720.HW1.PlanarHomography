function [H2to1, panoImg] = q5_2(img1, img2, pts)
    
    N = size(pts,2);
    
    %compute H
    H2to1 = computeH(pts(1:2,:), pts(3:4,:));
    
    %img2 extreme points
    img2_rows = size(img2,1);
    img2_cols = size(img2,2);
    img2_extreme_points = ones(3,4);
    img2_extreme_points(:,1) = [1;1;1]; %NW
    img2_extreme_points(:,2) = [img2_cols;1;1]; %NE
    img2_extreme_points(:,3) = [1;img2_rows;1]; %SW
    img2_extreme_points(:,4) = [img2_cols;img2_rows;1]; %SE
    
    %transform img2
    img2_extreme_points_warped = H2to1*img2_extreme_points;
    
    %normalize 3rd row
    img2_extreme_points_warped = bsxfun (@rdivide, img2_extreme_points_warped, img2_extreme_points_warped(3,:));
    
    
    %vertical traslation
    vertical_translation = abs(min(0 , min(img2_extreme_points_warped(2,:))));
    
    %horizontal translation
    horizontal_translation = abs(min(0 , min(img2_extreme_points_warped(1,:))));
    
    %combined image size
    x_max = max(size(img1,2),max(img2_extreme_points_warped(1,:)));
    x_min = min(1, min(img2_extreme_points_warped(1,:)));
    y_max = max(size(img1,1),max(img2_extreme_points_warped(2,:)));
    y_min = min(1, min(img2_extreme_points_warped(2,:)));
    combined_width = x_max - x_min;
    combined_height = y_max - y_min;
   
    %imposed dimensions
    imposed_width = 1280;
    imposed_height = floor(combined_height*(imposed_width/combined_width));
    
    
    %M matrix
    scale_factor = imposed_width/combined_width;
    vertical_translation = vertical_translation*scale_factor;
    horizontal_translation = horizontal_translation*scale_factor;
    
    M = [scale_factor 0 horizontal_translation; 0 scale_factor vertical_translation; 0 0 1];
    
    %apply transformation to both images
    img1_warped = warpH(img1, M, [imposed_height, imposed_width]);
    img2_warped = warpH(img2, M*H2to1, [imposed_height, imposed_width]);
    
    %overlay images
    out_size = [imposed_height, imposed_width];
    panoImg = overlay_images(img1_warped, img2_warped, out_size);
    
    disp(imposed_width);
    disp(imposed_height);
    
end