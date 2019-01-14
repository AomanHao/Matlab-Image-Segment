%% 程序分享
% 西安邮电大学图像处理团队-郝浩
% 个人博客 www.aomanhao.top
% Github https://github.com/AomanHao
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
figure;imshow(I);title('(a)原始图像')
imwrite(I,'1.jpg');
% I=I;%不加噪声
%I=imnoise(I,'speckle',deta_2);
% I=imnoise(I,'salt & pepper',0.05); %加噪图
% I=imnoise(I,'gaussian',0,0.01); % 加高斯噪声

%循环加噪声
% I=imnoise(I,'gaussian',0,noise); % 加高斯噪声
%  I=imnoise(I,'salt & pepper',noise); %加椒盐噪图
 
figure;imshow(I);title('(b)加噪图像');
imwrite(I,'2.jpg');
[m,n]=size(I);
%k 聚类数目
k=2;
% k=3;

I4 = I(:);  %% 将图像灰度按列排列
%% ------------------------ fcm算法------------------------
fcm_spatial_mean_label=zeros(m*n,1);
t=cputime;
tic;
[O2, U2, obj_fcn2] = fcm(I4, k);
toc;
time_fcm_spatial_mean=cputime-t;
%% 最大隶属度原则
maxU2 = max(U2);   %隶属度最大  
for j=1:k
    index = find(U2(j, :) == maxU2);  %隶属度最大对应的像素位置
    fcm_spatial_mean_label(index) = j;    
end
labels2=reshape(fcm_spatial_mean_label,[m n]);
labels2=uint16(labels2);

%% 显示聚类分割图
labels2(find(labels2==1))=0;
labels2(find(labels2==2))=255;
labels2(find(labels2==3))=180;
labels2(find(labels2==4))=100;
labels2=uint8(labels2);
figure;imshow(labels2,[]);title('(c)聚类分割图');
imwrite(labels2,'3.1.tiff','tiff','Resolution',300);%输出结果，保存为tif图片

