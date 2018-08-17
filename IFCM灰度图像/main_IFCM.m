clear
close all
clc
%% %%%%%%%%%%%%%%%图像%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 I=imread('3096.jpg');

if size(I,3) == 3
   I=rgb2gray(I);
else
end
I=im2double(I);
figure;imshow(I);title('(a)原始图像');imwrite(I,'1.jpg');
%I=I;%不加噪声
% I=imnoise(I,'speckle',deta_2);
% I=imnoise(I,'salt & pepper',0.05); %加噪图
% I=imnoise(I,'gaussian',0,0.01); % 加高斯噪声
%混合噪声
%I1=imnoise(I,'salt & pepper',0.01);
%I =imnoise(I1,'gaussian',0,0.01);
figure;imshow(I);title('(b)加噪图像');imwrite(I,'2.jpg');
[m,n]=size(I);

k=3;%聚类中心数目

I4 = I(:);  %% 将图像灰度按列排列
%% ------------------------ ifcm------------------------
ifcm__label=zeros(m*n,1);
t=cputime;
tic;
[O2, U2, obj_fcn2] = ifcm(I4, k);
toc;
time_fcm_spatial_mean=cputime-t;
maxU2 = max(U2);   %隶属度最大  
for j=1:k
    index = find(U2(j, :) == maxU2);  %隶属度最大对应的像素位置
    ifcm__label(index) = j;    
end
labels2=reshape(ifcm__label,[m n]);
labels2=uint16(labels2);

%显示聚类分割图
labels2(find(labels2==1))=0;
labels2(find(labels2==2))=255;
labels2(find(labels2==3))=125;
labels2(find(labels2==4))=180;
labels2=uint8(labels2);
% figure;imshow(labels2,[]);title('(c)聚类分割图');imwrite(labels2,'3.jpg');imwrite(labels2,'33.png')%保存为jpg
figure;imshow(labels2,[]);title('(c)聚类分割图');imwrite(labels2,'3.tiff','tiff','Resolution',300);%保存为tif
