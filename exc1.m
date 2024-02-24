
num_points = 9; % Number of points to mark
% Get the real points from the checkerboard
for n = 1:5
    % Construct the image file name
    image_file = sprintf('FixedCamera_Data/PatternImage_Orientation_%d.bmp', n);
    ima =  imread(image_file);
    [height,checkerboard_size_mm] = size(ima); % Size of the checkerboard in millimeters
    [coord , ima_pattern] = get_real_points_checkerboard_vmmc(num_points, checkerboard_size_mm,2);

    % Read the image
    coord_target = get_user_points_vmmc(image_file);
    homography = homography_solve_vmmc(coord',coord_target);
    tform = maketform('projective',homography');
    tr_ima = imtransform(ima_pattern,tform,'XData',[1 size(ima_pattern,2)],'YData',[1 size(ima_pattern,1)]);
    subplot(1, 5,n);
    imshow(tr_ima);

end


 