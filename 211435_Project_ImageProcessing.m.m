%MATLAB MINI PROJECT
%211435, 211438, 211444, 211230
clc;
clear all;

%IMPORTING IMAGE (FILE PATH NEEDS TO BE SPECIFIED IF NOT IN DIRECTORY)
imported_image=imread('D:\Coding Files\University\2022 ODD SEM\MATLAB\The_Blue_Marble_(remastered).jpg');
imshow(imported_image);

%SEGMENTING IMAGE - CHECKING RGB INTENSITIES

redseg=imported_image(:,:,1);
greenseg=imported_image(:,:,2);
blueseg=imported_image(:,:,3);

figure(1)
subplot(2,2,1);
imshow(imported_image);
title('Original Image');
subplot(2,2,2);
imshow(redseg);
title('Red Plane');
subplot(2,2,3);
imshow(greenseg);
title('Green Plane');
subplot(2,2,4);
imshow(blueseg);
title('Blue Plane');


%THRESHOLDING THE BLUE PLANE TO BE USED FOR IMAGE PROCESSING
figure(2)
level=0.37;
binarized_image=im2bw(blueseg,level);
subplot(2,2,1);
imshow(binarized_image);
title('Blue threshold');

%FILLING THE OBVIOUS HOLES - REDUCING NOISE
filled_holes=imfill(binarized_image,'holes');
subplot(2,2,2);
imshow(filled_holes);
title('Holes Removed');

%BLOB REMOVAL NEAR THE IMAGE BORDER
blob_removed=imclearborder(filled_holes);
subplot(2,2,3);
imshow(blob_removed);
title('Blobs removed');

%REMOVING BLOBS AND NOISE LESS THAN 7 PIXELS ACROSS
cleaned=strel('disk',7);
final_image=imopen(filled_holes,cleaned);
subplot(2,2,4);
imshow(final_image);
title('No small blob');

%MEASURING THE OBJECT DIAMETER
dm=regionprops(final_image,'MajorAxisLength');

%RESULT
figure(3)
imshow(imported_image)
d=imdistline;
disp('The Major Axis Length : ')
disp(dm)