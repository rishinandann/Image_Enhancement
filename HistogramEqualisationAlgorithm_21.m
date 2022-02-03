%Reading the original image
image=imread('lena512.bmp');
%imagesc(g_img, [0 255]);

%Generating the low contrast version 
g=min( max(round(0.2*image + 50),0),255);


subplot(3,2,1);
imshow(g);
title('Input Image ( low contrast )');
subplot(3,2,2);
imhist(g);
title('Histogram of input image');
str = {'x-axis: Gray Levels','y-axis: Pixel Count'};
text(175,7500,str)
axis tight;


% getting the count of pixels for a particular intensity.
h=zeros(1,256);
[r,c] = size(g);
total_pix=r*c;
n=0:255;

%%
j=histeq(g);
subplot(3,2,3);
imshow(j);
title('Image after Equalisation');
subplot(3,2,4);
d=imhist(j);
s1=stem(d);
set(s1,'Marker','none');
xlim([0 255]);
ylim([0 12000]);
title('Histogram equalisation using inbuilt function');
%%
%First we calculate the histogram without inbuilt function
for i=1:r
    for j=1:c
        h(g(i,j)+1)=h(g(i,j)+1)+1;
    end
end

%% 
% Calculate the probability
for i=1:256
    h(i)=h(i)/total_pix;
end
%%
% Calculate Cumulative Probability
temp=h(1);
for i=2:256
    temp=temp+h(i);
    h(i)=temp;
end

%%
% Now mapping - round to the nearest integer
for i=1:r
    for j=1:c
        g(i,j) = round(h(g(i,j)+1)*255);
    end
end
subplot(3,2,5);
imshow(g);
subplot(3,2,6);
c=imhist(g);
s2=stem(c);
set(s2,'Marker','none');
ylim([0 12000]);
xlim([0 255]);
title('Histogram Equalisation with implemented algorithm');

%First we normalise - generating the pdf - divide by total number of
%pixels.

