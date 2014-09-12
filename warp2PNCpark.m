function [img_yourname_warped, img_PNCpark_yourname] = warp2PNCpark(img_PNCpark, img_yourname, p1, p2)
    
    %compute H
    H = computeH(p1,p2);
    
    %compute img_yourname_warped
    img_yourname_warped = warpH(img_yourname, H, size(img_PNCpark(:,:,1)));
    
    
    %overlay my warped image on the park image 
    
    %create a mask for both regions (considering fill_value=0)
    mask_park = (img_yourname_warped(:,:,1) == 0).*(img_yourname_warped(:,:,2) == 0).*(img_yourname_warped(:,:,3) == 0);
    mask_myname = not(mask_park);
    
    %fill image according to region (pulls right pixel using the masks)
    img_PNCpark_yourname(:,:,1) = uint8(mask_park).*img_PNCpark(:,:,1) + uint8(mask_myname).*img_yourname_warped(:,:,1);
    img_PNCpark_yourname(:,:,2) = uint8(mask_park).*img_PNCpark(:,:,2) + uint8(mask_myname).*img_yourname_warped(:,:,2);
    img_PNCpark_yourname(:,:,3) = uint8(mask_park).*img_PNCpark(:,:,3) + uint8(mask_myname).*img_yourname_warped(:,:,3);
    
end