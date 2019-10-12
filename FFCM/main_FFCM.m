%% 程序分享 
% 西安邮电大学图像处理团队-郝浩
% 个人博客 www.aomanhao.top
% Github https://github.com/AomanHao
%--------------------------------------

clear
close all
clc
%% %%%%%%%%%%%%%%%图像%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I=imread('3096.jpg');
figure;imshow(I);title('(a)原始图像');imwrite(I,'1.1.tiff','tiff','Resolution',300);%保存为tif

if size(I,3) == 3
   I=rgb2gray(I);
else
end
figure;imshow(I);title('(b)灰度图像');imwrite(I,'1.2.tiff','tiff','Resolution',300);%保存为tif

%聚类数
k=2;
[m,n]=size(I);

I=im2double(I);
I4 = I(:);  %% 将图像灰度按列排列

%% ------------------------ IFFCM算法------------------------
fcm_spatial_mean_label=zeros(m*n,1);
t=cputime;
tic;
[center, U, obj_fcn2] = ffcm_spatial_information(I4,k);
toc;
time_fcm_spatial_mean=cputime-t;
maxU2 = max(U);   %隶属度最大  
for j=1:k
    index = find(U(j, :) == maxU2);  %隶属度最大对应的像素位置
    fcm_spatial_mean_label(index) = j;    
end
labels2=reshape(fcm_spatial_mean_label,[m n]);



%% 显示聚类分割图
labels2=uint8(labels2);
% figure;imshow(labels2,[]);title('(c)聚类分割图');imwrite(labels2,'3.jpg');imwrite(labels2,'33.png')%保存为jpg
figure;imshow(labels2,[]);title('(c)聚类分割图');imwrite(labels2,'3.tiff','tiff','Resolution',300);%保存为tif
