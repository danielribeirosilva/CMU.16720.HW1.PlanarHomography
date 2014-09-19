
%load images
img1 = imread('ec1.jpg');
img2 = imread('ec2.jpg');

%load points (variable called pts)
load('ec_pts.mat');

%run algorithm
[H2to1, panoImg] = q5_2(img1, img2, pts);

%show panorama
imshow(panoImg);