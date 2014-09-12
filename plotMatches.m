% Draw lines between corresponding points in two image
%   img1, img2, two images of equal size
%   pts - a 4xN matrix of points, where pts(1:2,:) are the points in image
%   1 and pts(3:4,:) are points in image 2.
function [] = plotMatches(img1,img2, pts);
if (size(img1) ~= size(img2))
    fprintf('Images must be the same size.\n');
    return
end

img = [img1 img2];
imshow(img);
axis equal;

lx = [pts(1,:); pts(3,:)+size(img1,2)];
ly = [pts(2,:); pts(4,:)];

perm = randperm(size(pts,2)) ;
sel = perm(1:100) ;

line(lx(:,sel),ly(:,sel),'Color','g');


end
