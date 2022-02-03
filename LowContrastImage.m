% Reading the original image
image=imread('lena512.bmp');
%imshow(image);
%%
%Simulating a low contrast image
g_img=min( max(round(0.5*image + 50),0),255);
%imshow(g_img);
%imhist(g_img);
%%
figure
subplot(2,2,1)
imshow(image);
title('Original Image');
subplot(2,2,2);
imhist(image);
title('Histogram of original image');
xlabel('Grayscale Range');
ylabel('Intensity Values Range');

subplot(2,2,3);
imshow(g_img);
title('Contrast reduced image');

subplot(2,2,4);
imhist(g_img);
title('Histogram of low contrast version of the image');
xlabel('Grayscale Range');
ylabel('Intensity Values Range');
