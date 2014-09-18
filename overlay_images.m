function panoImg = overlay_images(img1, img2, out_size)

    %overlay
    
    img1_big = uint8(zeros([out_size 3]));
    img1_big(1:size(img1,1),1:size(img1,2),:) = img1;
    
    %create a mask for both regions (considering fill_value=0)
    mask_taj1 = (img2(:,:,1) == 0).*(img2(:,:,2) == 0).*(img2(:,:,3) == 0);
    mask_taj2 = not(mask_taj1);
    
    %fill image according to region (pulls right pixel using the masks)
    panoImg = uint8(zeros(size(img2)));
    panoImg(:,:,1) = uint8(mask_taj1).*img1_big(:,:,1) + uint8(mask_taj2).*img2(:,:,1);
    panoImg(:,:,2) = uint8(mask_taj1).*img1_big(:,:,2) + uint8(mask_taj2).*img2(:,:,2);
    panoImg(:,:,3) = uint8(mask_taj1).*img1_big(:,:,3) + uint8(mask_taj2).*img2(:,:,3);
    
end
    