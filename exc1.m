checkerboard_size_mm = 320; % Size of the checkerboard in millimeters
num_points = 9; % Number of points to mark


% Get the real points from the checkerboard
[coord, ima_pattern] = get_real_points_checkerboard_vmmc(num_points, checkerboard_size_mm,0);

for n = 1:1
    disp(n)
    % Construct the image file name
    image_file = sprintf('FixedCamera_Data/PatternImage_Orientation_%d.bmp', n);
    ima =  imread(image_file);
    % Read the image
    coord_target{n} = get_user_points_vmmc(image_file);

    homography{n} = homography_solve_vmmc(coord',coord_target{n});
    tform = maketform('projective',homography{n}');
    tr_ima = imtransform(ima_pattern,tform,'XData',[1 size(ima_pattern,2)],'YData',[1 size(ima_pattern,1)]);
    subplot(1, 2,1);
    imshow(tr_ima);
 
end


 