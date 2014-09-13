function [H2to1, warpedImg, panoImg] = q5_1(img1, img2, pts)

    %load both images
    %img1 = imread('taj1r.jpg');
    %img2 = imread('taj2r.jpg');
    %load points
    %load('tajPts.mat');

    N = size(pts,2);

    %see correspondances
    %plotMatches(img1, img2, pts);

    %compute H
    H2to1 = computeH(pts(1:2,:), pts(3:4,:));
    %save
    save('q5_1.mat', 'H2to1');

    %apply homography to p2 points
    p2_transform = H2to1 * [pts(3:4,:); ones(1,N)];
    %normalize
    p2_transform = bsxfun (@rdivide, p2_transform, p2_transform(3,:));
    %remove last row (=1)
    p2_transform = p2_transform(1:2,:);
    %save
    save('q5_1_warpedFeatures.mat', 'p2_transform');

    %compute error
    error_square = pts(1:2,:) - p2_transform;
    error_square = error_square.*error_square;
    rms_error = sqrt(sum(sum(error_square)));
    disp(['RMS error: ' num2str(rms_error)]);
    
    %---------- end of q5.1.a ----------------
    
    %---------- start of q5.1.b --------------
    
    %warp taj2
    warpedImg = warpH(img2, H2to1, [size(img1,1) 3000]);
    %imshow(warpedImg);
    
    %overlay
    
    img1_big = uint8(zeros([size(img1,1) 3000 3]));
    img1_big(1:size(img1,1),1:size(img1,2),:) = img1;
    
    %create a mask for both regions (considering fill_value=0)
    mask_taj1 = (warpedImg(:,:,1) == 0).*(warpedImg(:,:,2) == 0).*(warpedImg(:,:,3) == 0);
    mask_taj2 = not(mask_taj1);
    
    %fill image according to region (pulls right pixel using the masks)
    panoImg = uint8(zeros(size(warpedImg)));
    panoImg(:,:,1) = uint8(mask_taj1).*img1_big(:,:,1) + uint8(mask_taj2).*warpedImg(:,:,1);
    panoImg(:,:,2) = uint8(mask_taj1).*img1_big(:,:,2) + uint8(mask_taj2).*warpedImg(:,:,2);
    panoImg(:,:,3) = uint8(mask_taj1).*img1_big(:,:,3) + uint8(mask_taj2).*warpedImg(:,:,3);
    
    %save image
    imwrite(panoImg, 'q5_1_pan.jpg');
    %imshow(panoImg);
    
    
end
