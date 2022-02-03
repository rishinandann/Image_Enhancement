%Reading the Original Image
lena=imread('lena512.bmp');

% %Generating the Salt and Pepper Noise
% im_saltp = lena;
% n = mynoisegen('saltpepper', 512, 512, .05, .05);
% im_saltp(n==0) = 0;
% im_saltp(n==1) = 255;

noise = mynoisegen('gaussian',512,512,0,64);
noise=uint8(noise);
noise1=lena+noise;
for i=1:512
    for j=1:512
        if noise1(i,j)<0
            noise1(i,j)=0;
        elseif noise1(i,j) >255
             noise1(i,j)=255;
        end
    end
end

%imshow(im_saltp);

%Implementing the Mean filter and convoluting with the input image
mean_filter = [ 1, 1, 1; 1, 1, 1; 1, 1, 1];
mean_filter = mean_filter .* (1/9);

filter1 = conv2(noise1, mean_filter);
% filter1 = conv2(im_saltp, mean_filter);
filter1 = uint8(filter1);
%imshow(filter1);

%Implementing the Median filter and traversing through the image
a = double(noise1);
% a = double(im_saltp);
b = a;
[row, col] = size(a);
for x = 2:1:row-1
    for y = 2:1:col-1
%% To make a 3x3 mask into a 1x9 mask
a1 = [a(x-1,y-1) a(x-1,y) a(x-1,y+1) a(x,y-1) a(x,y) a(x,y+1)...
    a(x+1,y-1) a(x+1,y) a(x+1,y+1)];
a2 = sort(a1);
med = a2(5); % the 5th value is the median 
b(x,y) = med;
    end
end
 
 subplot(2,3,1)
imshow(noise1)
% imshow(im_saltp)
title('Noisy Image (Gaussian)')
 
 subplot(2,3,4)
imhist(noise1)
 title('Histogram of Noisy Image (Gaussian)')
 
 subplot(2,3,2)
 imshow(uint8(b))
 title('Image with Median Filter on noisy image');
 
 subplot(2,3,5)
 imhist(uint8(b))
 title('Histogram After Denoising with Median Filter');
 
 subplot(2,3,3)
 imshow(uint8(filter1))
 title('Image with Mean Filter on noisy image')
 
subplot(2,3,6)
 imhist(uint8(filter1))
title('Histogram After Denoising with Mean Filter');