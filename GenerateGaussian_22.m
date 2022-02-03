image=imread('lena512.bmp');
%Generatimg Additive Gaussian noise
noise = mynoisegen('gaussian',512,512,0,64);
noise=uint8(noise);

%%
%Adding noise to original image and normalising the output to [0,255]
%grayscale values
noise1=image+noise;
for i=1:512
    for j=1:512
        if noise1(i,j)<0
            noise1(i,j)=0;
        elseif noise1(i,j) >255
             noise1(i,j)=255;
        end
    end
end

figure
subplot(2,2,1);
imshow(image);
title('Original image');
  
subplot(2,2,2);
imhist(image);
title('Histogram of Original image');
xlabel('Grayscale Range')
% xlim([0 grayLevels(end)]);
ylabel('Intensity Values Range');
subplot(2,2,2);
[pixelCount, grayLevels] = imhist(image);
bar(grayLevels, pixelCount); % Plot it as a bar chart.
grid on;
title('Histogram of original image');
xlabel('Gray Level');
ylabel('Pixel Count');
xlim([0 grayLevels(end)]); 
  
subplot(2,2,3);
imshow(noise1);
title('Image with Gaussian Noise');
  
subplot(2,2,4);
imhist(noise1);
title('Histogram of Noisy Image ( Gaussian )');
xlabel('Grayscale Range')
ylabel('Intensity Values Range');
[pixelCount1, grayLevels1] = imhist(noise1);
bar(grayLevels1, pixelCount1); % Plot it as a bar chart.
grid on;
title('Histogram of Noisy Image (Gaussian)');
xlabel('Gray Level');
ylabel('Pixel Count');
xlim([0 255]); 
%%
% C=noise1-image;
% subplot(1,3,1)
% imshow(C);
% title('Gaussian Noise');
% 
% subplot(1,3,2)
% imhist(C);
% legend('Histogram depicting the added Gaussian noise');
% 
% subplot(1,3,3)
% plot(C);






