function q43checker
	img_PNCpark = imread('pnc.jpg');
	img_yourname = imread('pnc_tomap.jpg');
	A = load('Q4.2.p1p2.mat');
	[img_yourname_warped, img_PNCpark_yourname]=warp2PNCpark(img_PNCpark, img_yourname, A.p1, A.p2);

	A.p1 = A.p1';
	A.p2 = A.p2';
	colors = ['r+'; 'b+'; 'g+'; 'm+'; 'c+'; 'k+'; 'w+'; 'y+'];
	subaxis(2,2,1, 'Spacing', 0.03, 'Padding', 0, 'Margin', 0);
	imshow(img_PNCpark);
	hold on;
	for u=1:size(A.p1, 1)
		plot(A.p1(u, 1), A.p1(u, 2), colors(mod(u-1,size(colors,1))+1, :), 'MarkerSize', 24, 'LineWidth', 6);
	end

	subaxis(2,2,2, 'Spacing', 0.03, 'Padding', 0, 'Margin', 0);
	imshow(img_yourname);
	hold on;
	for u=1:size(A.p2, 1)
		plot(A.p2(u, 1), A.p2(u, 2), colors(mod(u-1,size(colors,1))+1, :), 'MarkerSize', 24, 'LineWidth', 6);
	end

	subaxis(2,2,3, 'Spacing', 0.03, 'Padding', 0, 'Margin', 0);
	imshow(img_yourname_warped);

	subaxis(2,2,4, 'Spacing', 0.03, 'Padding', 0, 'Margin', 0);
	imshow(img_PNCpark_yourname);
end

