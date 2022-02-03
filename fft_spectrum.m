clear all;

input = imread('lena512.bmp');

r = 8; %degradation function
h = myblurgen('gaussian', r);

blur_image = conv2(input, h, 'same');

inp_img_dbl = double(input);
inp_img = padarray(inp_img_dbl,[8,8],'replicate',"both");
blur_img_dbl = conv2(inp_img, h, 'same');

%imshow(uint8(blur_image))
%subplot(1,2,1)
%imshow(uint8(blur_img_dbl));

input_fft = fft2(input);

F1 = log(1 + abs(input_fft));

ip_fft_shift = fftshift(input_fft);
F11 = log(1 + abs(ip_fft_shift));

subplot(2,3,1)
imshow(input)
title('original image')
subplot(2,3,2)
imshow(mat2gray(F1));
title('fft spectrum')
subplot(2,3,3)
imshow(mat2gray(F11));
title('shifted fft spectrum')

blur_fft = fft2(blur_img_dbl, 528, 528);
F2 = log(1 + abs(blur_fft));

blur_fft_shift = fftshift(blur_fft);
F22= log(1 + abs(blur_fft_shift));

subplot(2,3,4)
imshow(uint8(blur_image));
title('blurred image')
subplot(2,3,5)
imshow(mat2gray(F2));
title('fft spectrum')
subplot(2,3,6)
imshow(mat2gray(F22));
title('shifted fft spectrum')






