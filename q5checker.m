close all;
im1 = imread('taj1r.jpg');
im2 = imread('taj2r.jpg');
pts =load('tajPts.mat');
pts = pts.tajPts;
%plotMatches(im1,im2,pts);

%% Q5.1
[H2to1_q51,warped_q51,panoImg_q51]= q5_1(im1,im2,pts);
disp(H2to1_q51./H2to1_q51(3,3))
figure(1);
subaxis(2,1,1, 'Spacing', 0.03, 'Padding', 0, 'Margin', 0);
imshow(warped_q51);
subaxis(2,1,2, 'Spacing', 0.03, 'Padding', 0, 'Margin', 0);
imshow(panoImg_q51);


%% Q5.2
[H2to1_q52,panoImg_q52]= q5_2(im1,im2,pts);
figure(2); imshow(panoImg_q52);