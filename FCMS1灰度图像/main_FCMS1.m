clear
 noise_num=[0.001;0.002;0.006;0.01];%高斯噪声系数
% noise_num=[0.002;0.006;0.01];%椒盐噪声系数
% 
% noise_num=[0.02;0.05;0.1];
noise_type='guass';
% noise_type='salt';
% % noise_type='no_noise';
% noise_num=0.05;
for ii=1:3
    noise=noise_num(ii,:);

close all
clc
%% %%%%%%%%%%%%%%%选择图像%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I=imread('42049.jpg'); 
%  I=imread('238011.jpg');
% I=imread('15088.jpg');
%  I=imread('3063.jpg');
%  I=imread('135069.jpg');
%   I=imread('8068.jpg');
 I=imread('mmi3.png');
%  I=imread('3096.jpg');
%  I=imread('167062.jpg');
%  I=imread('24063.jpg');
%I=imread('sq2.png');
%  I=imread('42049.jpg');
%   I=imread('118035.jpg');
  %  I=imread('167062.jpg');
%   I=imread('100007.jpg');
%  I=imread('101027.jpg');
%   I=imread('106024.jpg');
%   I=imread('106025.jpg');
%   I=imread('108004.jpg');
%   I=imread('241004.jpg'); %4类
%   I=imread('253036.jpg');
%   I=imread('300091.jpg');
%   I=imread('55067.jpg');%8类
%   I=imread('296059.jpg');
%   I=imread('42044.jpg');%2类


if size(I,3) == 3
   I=rgb2gray(I);
else
end
figure;imshow(I);title('(a)原始图像');imwrite(I,'1.jpg');
%I=I;%不加噪声
% I=imnoise(I,'speckle',deta_2);
% I=imnoise(I,'salt & pepper',0.05); %加噪图
% I=imnoise(I,'gaussian',0,0.01); % 加高斯噪声

%循环加噪声
% I=imnoise(I,'gaussian',0,noise); % 加高斯噪声
 I=imnoise(I,'salt & pepper',noise); %加椒盐噪图
 
figure;imshow(I);title('(b)加噪图像');imwrite(I,'2.jpg');
[m,n]=size(I);

% k=3;
k=4;
r=3;
m_index=2;
beta=6;
% I = I/255；
I=im2double(I);
[I_mean,I_median]=compute_mean_median(I,r);%扩展邻域
% I_median=double(I_median);


I4 = I(:);  %% 将图像灰度按列排列
X_spatial_mean = I_mean(:);
% X_spatial_median = I_median(:);

%% ------------------------ fcm_spatial_mean------------------------
fcm_spatial_mean_label=zeros(m*n,1);
t=cputime;
tic;
[O2, U2, obj_fcn2] = fcm_spatial_information(I4,X_spatial_mean, k, beta,m_index);
toc;
time_fcm_spatial_mean=cputime-t;
maxU2 = max(U2);   %隶属度最大  
for j=1:k
    index = find(U2(j, :) == maxU2);  %隶属度最大对应的像素位置
    fcm_spatial_mean_label(index) = j;    
end
labels2=reshape(fcm_spatial_mean_label,[m n]);
labels2=uint16(labels2);

%% %%%%%%%%%%%%%%%%%%%%%%%%准确率%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% correct = renumber(clusts_real,psofcm_label)            %数据准确率
%load clabels-sq2.mat;  
% load clabels-238011.mat;  
% load clabels-3063.mat;
% load clabels-3096.mat
% load clabel-135069.mat
% load clabels-42049.mat
% load clabels-100007.mat
% load clabel-8068.mat
% load clabels-15088.mat
% load clabels-167062.mat
% load clabels-24063.mat
% load clabels-118035.mat
% load clabels-101027.mat
% load clabels-241004.mat
% load clabels-300091.mat
% load clabels-296059.mat
% load clabels-42044.mat
% load clabels-253036.mat
 
% clabels=imread('circles.png');%人工图的标准图
% clabels((clabels<50))=1;clabels((50<clabels & clabels<120) )=2;clabels((120<clabels & clabels<190))=3;clabels((190<clabels))=4;
% clabels=imread('mmi3.png');%人工图的标准图
% clabels((clabels<50))=1;clabels((50<clabels & clabels<120) )=2;clabels((120<clabels & clabels<190))=3;clabels((190<clabels))=4;

%% 评价指标
correct = renumber(clabels,labels2) ;              %图像准确率
[V_pc,V_pe_10,V_pe_e]=V_pcpe(U2); %划分系数，划分熵 
Vol=VOI_h(clabels,labels2,k);% 评价指标互信息VOI

%显示聚类分割图
labels2(find(labels2==1))=0;
labels2(find(labels2==2))=255;
labels2(find(labels2==3))=180;
labels2(find(labels2==4))=100;
labels2=uint8(labels2);
figure;imshow(labels2,[]);title('(c)聚类分割图');
imwrite(labels2,['3.1.','-',noise_type,'-',num2str(noise),'.tiff'],'tiff','Resolution',300);%保存为tif

% %显示标准分割图
% img_correct=clabels;
% img_correct(find(img_correct==1))=0;
% img_correct(find(img_correct==2))=255;
% img_correct(find(img_correct==3))=180;
% img_correct(find(img_correct==4))=255;
% img_correct=uint8(img_correct);
% % figure;imshow(img_correct,[]);title('(d)标准分割图');imwrite(img_correct,'4.jpg')%保存为jpg
% figure;imshow(img_correct,[]);title('(d)标准分割图');imwrite(img_correct,'4.tiff','tiff','Resolution',300)%保存为tif，300dpi


correct_end(ii,:)= roundn(correct,-4);
V_pc_end(ii,:) = roundn(V_pc,-4);
V_pe_10_end(ii,:) =roundn(V_pe_10,-4);
V_pe_e_end(ii,:) = roundn(V_pe_e,-4);
Vol_end(ii,:) = roundn(Vol,-4);
end